# A host which is used by host targets. Defaults to the current host.
HOST ?= $(shell hostname -s)

# Image format to use when generating host images with nixos-generate. Defaults to qcow.
HOST_IMAGE_FORMAT ?= qcow

VSCODE_EXT_INPUT_FILE=./modules/applications/vscode/extensions.txt
VSCODE_EXT_OUTPUT_FILE=./modules/applications/vscode/extensions.nix


#---( Switches )-----------------------------------------------------------------------------------

__USE_SUDO = 0

ifeq ($(shell hostname -s), $(HOST))
	__NIXOS_REBUILD_ARGS =
	__USE_SUDO = 1
else
	__NIXOS_REBUILD_ARGS = --no-build-nix --build-host $(HOST) --target-host $(HOST) --flake .\#$(HOST)
endif

ifeq ($(__USE_SUDO), 1)
	__SUDO = sudo
endif


#---( Targets )------------------------------------------------------------------------------------

update-libre:
	HOST=libre make host-update

update-vps2.kurthos.com:
	HOST=vps2.kurthos.com make host-update

update-vscode-extensions:
	@echo "Generating vscode extensions list. This will take a while..."
	cp $(VSCODE_EXT_OUTPUT_FILE) $(VSCODE_EXT_OUTPUT_FILE).bak
	./scripts/generate_vscode_extension_list.sh $(VSCODE_EXT_INPUT_FILE) > $(VSCODE_EXT_OUTPUT_FILE)

host-generate:
	@echo "Generating host image for $(HOST)..."
	nixos-generate -f $(HOST_IMAGE_FORMAT) -c hosts/$(HOST)/configuration.nix

host-update:
	@echo "Updating configuration for $(HOST)..."
	$(__SUDO) nixos-rebuild $(__NIXOS_REBUILD_ARGS) switch
