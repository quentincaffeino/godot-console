
## Supported console types.

### Engine types:

`TYPE_BOOL`, `TYPE_INT`, `TYPE_REAL` and `TYPE_STRING`.


### Custom types:

 - **IntRange**(*int* min_value, *int* max_value, *int* step)

`min_value` has the default value of 0

`max_value` has the default value of 100

`step` has the default value of 1

Difference between Int range and Float is that in Int range values are rounded to integers.


- **FloatRange**(*float* min_value, *float* max_value, *float* step)

`min_value` has the default value of 0

`max_value` has the default value of 100

`step` has the default value of 0


- **Filter**(*Array* filterList, *int* mode)

Possible `mode`s are: `Filter.ALLOW` and `Filter.DENY`. Default value is `ALLOW`


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
