
# Type


## Engine types:

[TYPE_BOOL](generated/BoolType.md), [TYPE_INT](generated/IntType.md), [TYPE_REAL](generated/FloaTypet.md), [TYPE_STRING](generated/StringType.md), [TYPE_VECTOR2](generated/Vector2Type.md), [TYPE_VECTOR3](generated/Vector3Type.md)


## Extra types:

[FilterType](generated/FilterType.md), [IntRangeType](generated/IntRangeType.md), [FloatRangeType](generated/FloatRangeType.md)

### Extra type usage example:

```gdscript
var health = 5

func _ready():
	Console.add_command('set_health', self, 'health')\
		.set_description('Set health')\
		.add_argument('health', Console.FloatRangeType.new(0, 5, 0.5))\
		.register()
```


## Creating custom types:

__Warning: Types API is unstable and may (and probably will) change.__

To add custom type extend `res://addons/quentincaffeino-console/src/Type/BaseType.gd` ([BaseType](generated/BaseType.md))
