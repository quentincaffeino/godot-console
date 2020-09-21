
const ActionService = preload('./ActionService.gd')
const DefaultActions = preload('./DefaultActions.gd')


# @var  Dictionary
const _default_actions = {
	DefaultActions.action_console_toggle: {
		"name": DefaultActions.action_console_toggle,
		"events": [
			{
				"scancode": KEY_QUOTELEFT,
			}
		]
	},
	DefaultActions.action_console_autocomplete: {
		"name": DefaultActions.action_console_autocomplete,
		"events": [
			{
				"scancode": KEY_TAB,
			}
		]
	},
	DefaultActions.action_console_history_up: {
		"name": DefaultActions.action_console_history_up,
		"events": [
			{
				"scancode": KEY_UP,
			}
		]
	},
	DefaultActions.action_console_history_down: {
		"name": DefaultActions.action_console_history_down,
		"events": [
			{
				"scancode": KEY_DOWN,
			}
		]
	}
}


# @returns  ActionService
static func create():
	return ActionService.new(InputMap, _default_actions)
