
# Console


#### Memeber Properties

| Properties | Description |
|--|--|
| [Log](https://github.com/QuentinCaffeino/godot-console/blob/docs/Log.md) | Logging class |
| [RegExLib](https://github.com/QuentinCaffeino/godot-console/blob/src/RegExLib.gd) | Regex used by console |
| readonly *bool* isConsoleShown |  |
| *bool* debugMode  | Enables more verbose logging output. Default: false |
| *bool* submitAutocomplete  | Autocomplete command when `ENTER` is pressed. Default: true |
| *string* action_console_toggle | Action name used to open the console |
| *string* action_history_up | Action name used to scroll history up |
| *string* action_history_down | Action name used to scroll history down |


#### Member Functions

| Methods | Description |
|--|--|
| *int* register(*string* alias, *Dictionary* params) | Register command |
| *int* unregister(*string* alias) | Unregister command |
| void write(string message) |  |
| void writeLine(string message) | Append new-line character at the end of the message |
| void clear() | Clear console |
| void toggleConsole() | Show console |
