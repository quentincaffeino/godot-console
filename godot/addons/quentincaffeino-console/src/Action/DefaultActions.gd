
# @var  String
const action_console_toggle = {
  "name": 'quentincaffeino_console_toggle',
  "events": [
    {
      "scancode": KEY_QUOTELEFT,
    }
  ]
}

# @var  String
const action_console_autocomplete = {
  "name": 'quentincaffeino_console_autocomplete',
  "events": [
    {
      "scancode": KEY_TAB,
    }
  ]
}

# @var  String
const action_console_history_up = {
  "name": 'quentincaffeino_console_history_up',
  "events": [
    {
      "scancode": KEY_UP,
    }
  ]
}

# @var  String
const action_console_history_down = {
  "name": 'quentincaffeino_console_history_down',
  "events": [
    {
      "scancode": KEY_DOWN,
    }
  ]
}


# @var  Dictionary
const actions = {
	action_console_toggle.name: action_console_toggle,
	action_console_autocomplete.name: action_console_autocomplete,
	action_console_history_up.name: action_console_history_up,
	action_console_history_down.name: action_console_history_down
}
