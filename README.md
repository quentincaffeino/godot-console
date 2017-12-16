Godot Console
============

Quake-style console for Godot. **Requires a Godot 3.0**.

![Quake-style console for Godot](https://github.com/QuentinCaffeino/godot-console/blob/master/screenshot_3.png)

## Features

- Easily extensible with new commands
- Toggle-able with fade animation
- Rich text format (colors, bold, italic, and more) using a RichTextLabel
- Auto-completion on TAB
- History
- Custom types (`Filter`, `IntRange`, `FloatRange`)

## Installation

1. Clone or download this repository
2. Copy `Console` folder to any directory of your project
3. Add `Console/Console.tscn` to Autoload
4. Add new actions to Input Map: "console_toggle", "console_up", "console_down"

## Example

```gdscript
func _ready():
	Console.register('sayHello', { # Command name
		'type': Console.METHOD,
			# If you want to add a variable
			# then Console.VARIABLE is used

		'name': 'print_hello',
			# Function to call. If name is same
			# as command name then this
			# parametr isn't required

		'description' = 'Prints hello world',

		'args' = [ARGUMENT, ...],  # If METHOD.
			# This argument is obsolete if
			# function doesn't take any arguments

		'arg' = ARGUMENT,          # If VARIABLE

		'target' = self
			# Target script to bind command to

	})

func print_hello():
	Console.writeLine('Hello world!')
```

***ARGUMENT*** should look like this:
- ['arg_name', ***ARG_TYPE***]
- 'arg_name' — In this situation type will be set to Any
- ***ARG_TYPE***

***ARG_TYPE*** must be set to engine `TYPE_*` constant (right now supported types are: `TYPE_BOOL`, `TYPE_INT`, `TYPE_REAL` and `TYPE_STRING`) OR to instance of Console type class  (`Console/Commands/Types/`).

You can find more examples in `scripts/custom_register_script.gd`

## License

Copyright (c) 2017 Mankind

Licensed under the MIT license, see `LICENSE.md` for more information.
