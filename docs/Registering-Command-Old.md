
# Registering Command

## The old way (will be deprecated and later removed)

#### Kept for compatibility reasons and it is strongly discouraged to continue using this method for registering new commands.

```gdscript
func _ready():
	Console.register('sayHello', { # Command name

		'description': 'Prints "Hello %name%!"',

		# This argument is obsolete if target function doesn't take any arguments.
		# If target is a variable then it takes one argument to set it, and zero to get its value.
		# You can fild more about how argument should look like below.
		# ARGUMENT[]
		'args': [[ 'name', TYPE_STRING ]],

		# Target to bind command to.
		# Providing name is obsolete if it is same as a command name.
			# [Object, variable/method name]
		'target': [ self, 'printHello' ]

	})
```

***ARGUMENT*** should look like this:
- [ 'arg_name', [**ARG_TYPE**](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/Type.md) ]
- 'arg_name' — In this situation type will be set to Any
- [**ARG_TYPE**](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/Type.md)

More information about [**ARG_TYPE**](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/Type.md) you can find [here](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/Type.md).

More examples in [`src/BaseCommands.gd`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Misc/BaseCommands.gd)
