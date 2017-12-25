
Godot Console
============

Great thanks to [@Krakean](https://github.com/Krakean/godot-console) and [@DmitriySalnikov](https://github.com/DmitriySalnikov/godot-console) for the motivation to keep improving the [original](https://github.com/Calinou/godot-console) console c:

Also they have their own implementations which you can checkout.

----------

In-game console for Godot, easily extensible with new commands.
**Requires a Godot 3.0**.

![Quake-style console for Godot](https://github.com/QuentinCaffeino/godot-console/blob/master/screenshot.png)

## Features

- Writing to console using `write` and `writeLine` method.

	`Console.writeLine('Hello world!')`

	(Also printed to engine output)
- Auto-completion (`TAB` button)
- History (using with actions `console_up` and `console_down`)
- Custom types (`Filter`, `IntRange`, `FloatRange`)
- Changeable log levels (`INFO`, `WARNING`, `ERROR` and `NONE`)

	`Console.Log.setLogLevel(Console.Log.INFO)`
- Writing log messages using `info`, `warn` and `error` methods

	`Console.Log.warn('u so pretty')`

## Installation

1. Clone or download this repository.
2. Copy `Console` folder to any directory of your project.
3. Add `Console/Console.tscn` to Autoload.
4. Add new actions to Input Map: `console_toggle`, `console_up`, `console_down`.

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

		'description': 'Prints hello world',

		'args': [ARGUMENT, ...],  # If METHOD.
			# This argument is obsolete if
			# function doesn't take any arguments

		'arg': ARGUMENT,          # If VARIABLE

		'target': self
			# Target script to bind command to

	})

func print_hello():
	Console.writeLine('Hello world!')
```

***ARGUMENT*** should look like this:
- ['arg_name', **[ARG_TYPE](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/README.md)**]
- 'arg_name' — In this situation type will be set to Any
- **[ARG_TYPE](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/README.md)**

More information about **[ARG_TYPE](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/README.md)** you can find in [this readme](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/README.md).

You can find more examples in `example/script.gd`

## License

Copyright (c) 2017 Mankind

Licensed under the MIT license, see `LICENSE.md` for more information.
