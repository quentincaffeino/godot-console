# godot-callback

Wrapper class to allow easy and unified usage of callbacks.

## Examples:

```gdscript
const CallbackBuilderFactory = preload('res://addons/@quentincaffeino/godot-callback/src/CallbackBuilderFactory.gd')


# @var  Value
var callable_prop = "Hello world!"

# @param  Variant  value
func callable_function(value):  # Callable
	callable_prop = value
	return self


func _ready():
	# Property callback
	var prop_cb = CallbackBuilderFactory.get_callback_builder(self)\
		.set_name("callable_prop")\
		.build()
	print(prop_cb.call())  # Prints: Hello world!

	# Function callback
	var func_cb = CallbackBuilderFactory.get_callback_builder(self)\
		.set_name("callable_function")\
		.build()
	func_cb.call(["Hello, sam!"])
	print(prop_cb.call())  # Prints: Hello, sam!

	# Function callback via Funcref
	var fr = funcref(self, "callable_function")
	var funcref_cb = CallbackBuilderFactory.get_callback_builder(fr).build()
	funcref_cb.call(["Hello, peter!"])
	print(prop_cb.call())  # Prints: Hello, peter!
```

## License

See more in LICENSE.md
