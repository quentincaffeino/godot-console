# godot-callback

Wrapper class to allow easy passing a reference to classes parameters/methods.

## Examples:

```gdscript
const CallbackBuilder = preload('res://addons/quentincaffeino/callback/src/CallbackBuilder.gd')


# @var  Value
var callable_prop = "Hello world!"

# @param  Variant  value
func callable_function(value):  # Callable
	callable_prop = value
	return self


func _ready():  # void
	var prop_cb = CallbackBuilder.new(self).set_name("callable_prop").build()
	var func_cb = CallbackBuilder.new(self).set_name("callable_function").build()
	var funcref_cb = CallbackBuilder.new(funcref(self, "callable_function")).build()

	print(prop_cb.call())  # Prints: Hello world!

	print(func_cb.call(["Hello, sam!"]))  # Prints: [Reference...]
	print(prop_cb.call())  # Prints: Hello, sam!

	print(funcref_cb.call(["Hello, peter!"]))  # Prints: [Reference...]
	print(prop_cb.call())  # Prints: Hello, peter!
```

## License

See more in LICENSE.md
