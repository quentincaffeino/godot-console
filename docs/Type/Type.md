
# Type.


### Engine types:

[`TYPE_BOOL`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/Bool.gd), [`TYPE_INT`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/Int.gd), [`TYPE_REAL`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/Float.gd), [`TYPE_STRING`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/String.gd), [`TYPE_VECTOR2`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/Vector2.gd)


### Custom types:

 - [**IntRange**](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/IntRange.md) (*int* min_value = 0, *int* max_value = 100, *int* step = 1)

Difference between Int range and Float range is that in Int range values are rounded to integers.


- [**FloatRange**](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/FloatRange.md) (*float* min_value = 0, *float* max_value = 100, *float* step = 0)


- [**Filter**](https://github.com/QuentinCaffeino/godot-console/blob/dev/docs/Type/Filter.md) (*Variant[]* filterList, *int* mode = ALLOW)

Possible `mode`s are: `Filter.ALLOW` and `Filter.DENY`


### Example

```gdscript
var health = 5

func _ready():
	Console.register('set_health', {
		'description': 'Set health',
		'args': [ Console.FloatRange.new(0, 5, 0.5) ],
		'target': [ self, 'health' ]
	})
```


### Adding your own types

__Warning: Types API is unstable and may (and probably will) change.__

To add custom type extend [`Console/Commands/Type/BaseType.gd`](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/BaseType.gd)
