VSCODE_EXT_INPUT_FILE=./modules/applications/vscode/extensions.txt
VSCODE_EXT_OUTPUT_FILE=./modules/applications/vscode/extensions.nix

update-vscode-extensions:
	@echo "Generating vscode extensions list. This will take a while..."
	cp $(VSCODE_EXT_OUTPUT_FILE) $(VSCODE_EXT_OUTPUT_FILE).bak
	./scripts/generate_vscode_extension_list.sh $(VSCODE_EXT_INPUT_FILE) > $(VSCODE_EXT_OUTPUT_FILE)
