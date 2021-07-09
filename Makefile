
GODOT ?= $(shell which godot)

GDSCRIPT_DOCS_MAKER_BIN_NAME="godot_generate_reference"
GDSCRIPT_DOCS_MAKER="${PWD}/gdscript-docs-maker/generate_reference"
GDSCRIPT_DOCS_MAKER_PATH=$(shell dirname "${GDSCRIPT_DOCS_MAKER}")

PROJECT_DEMO_PATH="${PWD}/demo"
ADDON_PATH="${PROJECT_DEMO_PATH}/addons/quentincaffeino/console"
ADDON_DOCS_PATH="${ADDON_PATH}/docs/generated"


.PHONY: run-demo
run-demo:
	@(cd "${PROJECT_DEMO_PATH}" && "${GODOT}" -v)

.PHONY: run-demo-editor
run-demo-editor:
	@(cd "${PROJECT_DEMO_PATH}" && "${GODOT}" -v -e)


.PHONY: generate-docs
generate-docs:
	@(cd "${GDSCRIPT_DOCS_MAKER_PATH}" && \
		"${GDSCRIPT_DOCS_MAKER}" "${PROJECT_DEMO_PATH}" -o "${ADDON_DOCS_PATH}")


.PHONY: test
test:
	find addons/quentincaffeino/ -name ".gutconfig.json" -type f -print | xargs -d0 -I{} "${GODOT}" -s addons/gut/gut_cmdln.gd -d --path demo/ -gconfig="res://{}"
