
# @const  String
const CONSOLE_TOGGLE = "quentincaffeino_console_toggle"
# @const  Dictionary
const console_toggle_props = {
  "name": CONSOLE_TOGGLE,
  "events": [
    {
      "command": true,
      "scancode": KEY_QUOTELEFT,
    }
  ]
}

# @const  String
const CONSOLE_AUTOCOMPLETE = "quentincaffeino_console_autocomplete"
# @const  Dictionary
const console_autocomplete_props = {
  "name": CONSOLE_AUTOCOMPLETE,
  "events": [
    {
      "scancode": KEY_TAB,
    }
  ]
}

# @const  String
const CONSOLE_HISTORY_UP = "quentincaffeino_console_history_up"
# @const  Dictionary
const console_history_up_props = {
  "name": CONSOLE_HISTORY_UP,
  "events": [
    {
      "scancode": KEY_UP,
    }
  ]
}

# @const  String
const CONSOLE_HISTORY_DOWN = "quentincaffeino_console_history_down"
# @const  Dictionary
const console_history_down_props = {
  "name": CONSOLE_HISTORY_DOWN,
  "events": [
    {
      "scancode": KEY_DOWN,
    }
  ]
}
