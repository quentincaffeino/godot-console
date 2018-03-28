

Godot Console
============

In-game console for Godot, easily extensible with new commands.

![Quake-style console for Godot](https://github.com/QuentinCaffeino/godot-console/blob/master/screenshot.png)

## Features

- Writing to console using `write` and `writeLine` method. You can use [BB codes](https://godot.readthedocs.io/en/latest/learning/features/gui/bbcode_in_richtextlabel.html?highlight=richtextlabel#reference). (Also printed to engine output)

	`Console.writeLine('Hello world!')`

- Auto-completion on `TAB` (complete command), `Enter` (complete and execute).
- History (by default using with actions `ui_up` and `ui_down`)
- Custom types (`Filter`, `IntRange`, `FloatRange`, [and more...](https://github.com/QuentinCaffeino/godot-console/blob/master/docs/Types.md))
- [Logging](https://github.com/QuentinCaffeino/godot-console/tree/master/docs/Log.md)

## Installation

1. Clone or download this repository to your project folder.
2. Add `src/Console.tscn` to godot autoload as `Console`.
3. Add new actions to Input Map: `console_toggle`, `ui_up`, `ui_down`

## Example

### Registering command:

```gdscript
func _ready():
	Console.register('sayHello', { # Command name

		'description': 'Prints hello world',

		'args': [ARGUMENT, ...],
			# This argument is obsolete if
			# target function doesn't
			# take any arguments

			# [Object, variable/method name]
		'target': [self, 'print_hello']
			# Target to bind command.
			# Providing name is obsolete
			# if command name is same.

	})

func print_hello():
	Console.writeLine('Hello world!')
```

***ARGUMENT*** should look like this:
- ['arg_name', [**ARG_TYPE**](https://github.com/QuentinCaffeino/godot-console/blob/master/docs/Types.md)]
- 'arg_name' — In this situation type will be set to Any
- [**ARG_TYPE**](https://github.com/QuentinCaffeino/godot-console/blob/master/docs/Types.md)

More information about [**ARG_TYPE**](https://github.com/QuentinCaffeino/godot-console/blob/master/docs/Types.md) you can find in [this readme](https://github.com/QuentinCaffeino/godot-console/blob/master/docs/Types.md).

You can find more examples in [`src/BaseCommands.gd`](https://github.com/QuentinCaffeino/godot-console/blob/master/src/BaseCommands.gd)

----------

Great thanks to [@Krakean](https://github.com/Krakean/godot-console) and [@DmitriySalnikov](https://github.com/DmitriySalnikov/godot-console) for the motivation to keep improving the [original](https://github.com/Calinou/godot-console) console by [@Calinou](https://github.com/Calinou).

Take a look at their implementations.

## License

Licensed under the MIT license, see `LICENSE.md` for more information.
