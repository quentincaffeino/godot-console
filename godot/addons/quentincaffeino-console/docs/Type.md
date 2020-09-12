
# Type


## Engine types:

[TYPE_BOOL](godot/addons/quentincaffeino-console/docs/generated/BoolType.md), [TYPE_INT](godot/addons/quentincaffeino-console/docs/generated/IntType.gd), [TYPE_REAL](godot/addons/quentincaffeino-console/docs/generated/FloaTypet.gd), [TYPE_STRING](godot/addons/quentincaffeino-console/docs/generated/StringType.gd), [TYPE_VECTOR2](godot/addons/quentincaffeino-console/docs/generated/Vector2Type.gd), [TYPE_VECTOR3](godot/addons/quentincaffeino-console/docs/generated/Vector3Type.gd)


## Extra types:

[FilterType](godot/addons/quentincaffeino-console/docs/generated/FilterType.md), [IntRangeType](godot/addons/quentincaffeino-console/docs/generated/IntRangeType.md), [FloatRangeType](godot/addons/quentincaffeino-console/docs/generated/FloatRangeType.md)

### Extra type usage example:

```gdscript
var health = 5

func _ready():
	Console.addCommand('set_health', self, 'health')\
		.setDescription('Set health')\
		.addArgument('health', Console.FloatRangeType.new(0, 5, 0.5))\
		.register()
```


## Creating custom types:

__Warning: Types API is unstable and may (and probably will) change.__

To add custom type extend [`Console/Commands/Type/BaseType.gd`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/BaseType.gd)
