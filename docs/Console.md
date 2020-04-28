
# **Console** extends CanvasLayer


[Code](../src/Console.gd)


#### Memeber Properties

| Properties | Description |
|--|--|
| const [*FloatRange*](Type/FloatRange.md) | Custom FloatRange type class. |
| const [*Filter*](Type/Filter.md) | Custom Filter type class. |
| readonly [*Log*](https://github.com/quentincaffeino/godot-console/tree/master/docs/Log.md) | Logging class. |
| readonly *bool* isConsoleShown |  |
| *bool* submitAutocomplete  | Autocomplete command when `ENTER` is pressed. Default: *true*. |
| *string* action_console_toggle | Action name used to open the console. Default: *console_toggle*. |
| *string* action_history_up | Action name used to scroll history up. Default: *ui_up*. |
| *string* action_history_down | Action name used to scroll history down. Default: *ui_down*. |


#### Member Functions

| Methods | Description |
|--|--|
| *Command/Command\|null* getCommand(*string* name) | Get command by name. |
| *bool* register(*string* name, *Variant[][]* parameters = []) | Register command. |
| *int* unregister(*string* name) | Unregister command. |
| *void* write(*string* message) | Writes message to the console and engine output. |
| *void* writeLine(*string* message = '') | Writes message and appends new-line character at the end of the message. |
| *void* clear() | Clear console. |
| *void* toggleConsole() | Show console. |
