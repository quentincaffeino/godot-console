# godot-regexlib

Usefull regex stuff.


## Examples:

```gdscript
const RegExLib = preload('res://addons/quentincaffeino-regexlib/src/RegExLib.gd')

func _ready():
	var regExLib = RegExLib.new()
	print(regExLib.getPatternFor(TYPE_INT))  # Prints: pattern for int type
```


## Todo:

- Cache compiled patterns in `split` method.


## License

See more in LICENSE.md
