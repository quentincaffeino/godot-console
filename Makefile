
GODOT=$(shell which godot)

GDSCRIPT_DOCS_MAKER_BIN_NAME="godot_generate_reference"
GDSCRIPT_DOCS_MAKER=$(shell readlink $(shell which "${GDSCRIPT_DOCS_MAKER_BIN_NAME}"))
GDSCRIPT_DOCS_MAKER_PATH=$(shell dirname "${GDSCRIPT_DOCS_MAKER}")

PROJECT_PATH="${PWD}/godot"
ADDON_PATH="${PROJECT_PATH}/addons/quentincaffeino-console"
ADDON_DOCS_PATH="${ADDON_PATH}/docs/generated"


.PHONY: run-demo
run-demo:
	@(cd "${PROJECT_PATH}" && "${GODOT}")

.PHONY: run-demo-editor
run-demo-editor:
	@(cd "${PROJECT_PATH}" && "${GODOT}" -e)


.PHONY: generate-docs
generate-docs:
	@(cd "${GDSCRIPT_DOCS_MAKER_PATH}" && \
		"${GDSCRIPT_DOCS_MAKER}" "${PROJECT_PATH}" -o "${ADDON_DOCS_PATH}")


.PHONY: test
test:
	@(cd "${PROJECT_PATH}" && \
		"${GODOT}" -s res://addons/gut/gut_cmdln.gd -d)
