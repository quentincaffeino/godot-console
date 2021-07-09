tool
extends EditorPlugin

const DefaultActions = preload("./DefaultActions.gd")


const PLUGIN_NAME = 'Console'
const PLUGIN_PATH = 'res://addons/quentincaffeino/console/src/Console.tscn'

# @var  Array
const ACTIONS = [
	DefaultActions.console_toggle_props,
	DefaultActions.console_autocomplete_props,
	DefaultActions.console_history_up_props,
	DefaultActions.console_history_down_props
]


func _enter_tree():
	self.add_autoload_singleton(PLUGIN_NAME, PLUGIN_PATH)

	# Register input events
	for action_props in ACTIONS:
		var setting_name = "input/" + action_props["name"]

		if not ProjectSettings.has_setting(setting_name):
			var events = []

			var action_props_events = action_props["events"]

			for event_data in action_props_events:
				var event = InputEventKey.new()
				for prop_name in event_data:
					event.set(prop_name, event_data[prop_name])

				events.append(event)

			ProjectSettings.set_setting(setting_name, {
				"deadzone": float(action_props["deadzone"] if "deadzone" in action_props else 0.5),
				"events": events
			})

	var result = ProjectSettings.save()
	assert(result == OK, "Failed to save project settings")


func _exit_tree():
	self.remove_autoload_singleton(PLUGIN_NAME)
