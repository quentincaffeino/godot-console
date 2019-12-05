# godot-callback

Wrapper class to allow seamlessly passing reference or/and call other class variables/properties.

## Examples:

```gdscript
const Callback = preload('res://addons/quentincaffeino-callback/src/Callback.gd')


class Callable:

	# @var  Value
	var callableProp = 'Hello world!'

	# @param  Variant  value
	func callableFunction(value):  # Callable
		callableProp = value
		return self


func _ready():  # void
	var callable = Callable.new()
	var propCb = Callback.new(callable, 'callableProp')
	var funcCb = Callback.new(callable, 'callableFunction')

	print(propCb.call())  # Prints: Hello world!
	print(funcCb.call(['Hello, sam!']))  # Prints: [Reference...]
	print(propCb.call())  # Prints: Hello, sam!
```

## License

See more in LICENSE.md
