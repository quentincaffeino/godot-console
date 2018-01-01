
## Supported console types.

### Engine types:

[`TYPE_BOOL`](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/Bool.gd), [`TYPE_INT`](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/Int.gd), [`TYPE_REAL`](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/Float.gd) and [`TYPE_STRING`](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/String.gd).


### Custom types:

 - [**IntRange**](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/IntRange.gd)(*int* min_value, *int* max_value, *int* step)

`min_value` has the default value of 0

`max_value` has the default value of 100

`step` has the default value of 1

Difference between Int range and Float is that in Int range values are rounded to integers.


- [**FloatRange**](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/FloatRange.gd)(*float* min_value, *float* max_value, *float* step)

`min_value` has the default value of 0

`max_value` has the default value of 100

`step` has the default value of 0


- [**Filter**](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/Filter.gd)(*Array* filterList, *int* mode)

Possible `mode`s are: `Filter.ALLOW` and `Filter.DENY`. Default value is `ALLOW`


### Adding your own types

To add custom type extend [`Console/Commands/Types/BaseType.gd`](https://github.com/QuentinCaffeino/godot-console/blob/master/Console/Commands/Types/BaseType.gd)


## Example

```gdscript
var health = 55

func _ready():
	Console.register('set_health', {
		'description': 'Set health',
		'args': [Console.FloatRange.new(0, 100, 0.5)],
		'target': [self, 'health']
	})
```
