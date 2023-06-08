#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq unzip
# shellcheck shell=bash
set -eu -o pipefail

# can be added to your configuration with the following command and snippet:
# $ ./generate_vscode_extension_list.sh extensions.txt > extensions.nix
#
# packages = with pkgs;
#   (vscode-with-extensions.override {
#     vscodeExtensions = map
#       (extension: vscode-utils.buildVscodeMarketplaceExtension {
#         mktplcRef = {
#          inherit (extension) name publisher version sha256;
#         };
#       })
#       (import ./extensions.nix).extensions;
#   })
# ]
#
# with flakes/home-manager:
#
# programs.vscode = {
#     enable = true;
#     extensions = (builtins.map
#       (extension: pkgs.vscode-utils.buildVscodeMarketplaceExtension {
#         mktplcRef = {
#           inherit (extension) name publisher version sha256;
#         };
#       }) extensions);
#

# Helper to just fail with a message and non-zero exit code.
function fail() {
    echo "$1" >&2
    exit 1
}

function usage() {
    echo ""
    echo "usage: $0 INPUT_FILE"
    echo ""
    echo "Arguments:"
    echo "  INPUT_FILE      file containing a list of extensions in the format 'publisher.extension'"
    exit 1
}

# Helper to clean up after ourselves if we're killed by SIGINT.
function clean_up() {
    TDIR="${TMPDIR:-/tmp}"
    echo "Script killed, cleaning up tmpdirs: $TDIR/vscode_exts_*" >&2
    rm -Rf "$TDIR/vscode_exts_*"
}

function get_vsixpkg() {
    N="$1.$2"

    # Create a tempdir for the extension download.
    EXTTMP=$(mktemp -d -t vscode_exts_XXXXXXXX)

    URL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    curl --silent --show-error --retry 3 --fail -X GET -o "$EXTTMP/$N.zip" "$URL"

    # Unpack the file we need to stdout then pull out the version
    VERSION=$(jq -r '.version' <(unzip -qc "$EXTTMP/$N.zip" "extension/package.json"))

    # Redownload the archive with the specific version to get the correct sha256 hash
    URL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/$VERSION/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    curl --silent --show-error --retry 3 --fail -X GET -o "$EXTTMP/$N.zip" "$URL"
    SHA=$(nix hash file "$EXTTMP/$N.zip")

    # Clean up.
    rm -Rf "$EXTTMP"
    # I don't like 'rm -Rf' lurking in my scripts but this seems appropriate.

    cat <<-EOF
    {
      name = "$2";
      publisher = "$1";
      version = "$VERSION";
      sha256 = "$SHA";
    }
EOF
}

if [ $# -ne 0 ]; then
    INPUT=$1
else
    usage
fi

if [ -z "$INPUT" ]; then
    fail "No input file specified"
fi

# Try to be a good citizen and clean up after ourselves if we're killed.
trap clean_up SIGINT

# Begin the printing of the nix expression that will house the list of extensions.
printf '{\n  extensions = [\n'

# Note that we are only looking to update extensions that are already installed.
while IFS= read -r line
do
    [[ $line = \#* ]] && continue

    OWNER=$(echo "$line" | cut -d. -f1)
    EXT=$(echo "$line" | cut -d. -f2)

    get_vsixpkg "$OWNER" "$EXT"
done < "$INPUT"

# Close off the nix expression.
printf '  ];\n}\n'
