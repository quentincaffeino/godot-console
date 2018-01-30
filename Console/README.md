

## Console

| Properties | Description |
|--|--|
| [Log](#log) | Logging class |
| RegExLib | Regex used by console |
| readonly *bool* isConsoleShown |  |
| *bool* debugMode  | Enables more verbose logging output. Default: false |
| *bool* submitAutocomplete  | Autocomplete command when `ENTER` is pressed. Default: true |
| *string* action_console_toggle | Action name used to open the console |
| *string* action_history_up | Action name used to scroll history up |
| *string* action_history_down | Action name used to scroll history down |

| Methods | Description |
|--|--|
| *int* register(*string* alias, *Dictionary* params) | Register command |
| *int* unregister(*string* alias) | Unregister command |
| void write(string message) |  |
| void writeLine(string message) | Append new-line character at the end of the message |
| void toggleConsole() | Show console |


## Log

| Properties | Description |
|--|--|
| *int* logLevel |  |

| Methods | Description |
|--|--|
| *void* setLogLevel(*int* inLogLevel = INFO) | Messages lower than provided level won't show in console output |
| *void* log(*string* message, *int* type = INFO) |  |
| *void* info(*string* message, *string* debugInfo = '') |  |
| *void* warn(*string* message, *string* debugInfo = '') |  |
| *void* error(*string* message, *string* debugInfo = '') |  |

#### Log level enum
- INFO
- WARNING
- ERROR
- NONE
