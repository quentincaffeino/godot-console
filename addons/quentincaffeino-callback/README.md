# godot-callback

Wrapper class to allow seamlessly passing reference or/and call other class variables/properties.

## Examples:

```gdscript
const CallbackBuilder = preload('res://addons/quentincaffeino-callback/src/CallbackBuilder.gd')


# @var  Value
var callableProp = 'Hello world!'

# @param  Variant  value
func callableFunction(value):  # Callable
	callableProp = value
	return self


func _ready():  # void
	var propCb = CallbackBuilder.new(self).setName('callableProp').build()
	var funcCb = CallbackBuilder.new(self).setName('callableFunction').build()
	var funcRefCb = CallbackBuilder.new(funcref(self, 'callableFunction')).build()

	print(propCb.call())  # Prints: Hello world!

	print(funcCb.call(['Hello, sam!']))  # Prints: [Reference...]
	print(propCb.call())  # Prints: Hello, sam!

	print(funcRefCb.call(['Hello, peter!']))  # Prints: [Reference...]
	print(propCb.call())  # Prints: Hello, peter!
```

## License

See more in LICENSE.md
