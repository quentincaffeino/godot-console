# godot-iterator

Wrapper class to allow iterating through class properties.

## Examples:

### 1. Iterating through regular dictionary:

```gdscript
const Iterator = preload('res://addons/quentincaffeino-iterator/src/Iterator.gd')


# @var  Dictionary
var _data = {
	'key1': 'val1',
	'key2': 'val2',
	'key3': 'val3'
}


func _ready():  # void
	for key in _data:
		print(key)

	# Output:
	# key1
	# key2
	# key3

	var iterator = Iterator.new(_data)
	for val in iterator:
		print(val)

	# Output:
	# val1
	# val2
	# val3
```

### 2. Iterating custom class

```gdscript
const Iterator = preload('res://addons/iterator/src/Iterator.gd')


class DataIterable:

	# @var  Dictionary
	var _data = {
		'key1': 'val1',
		'key2': 'val2',
		'key3': 'val3'
	}


	func getValueIterator():  # Iterator
		return Iterator.new(_data)


func _ready():
	var dataIterable = DataIterable.new()

	for val in dataIterable.getValueIterator():
		print(val)

	# Output:
	# val1
	# val2
	# val3
```

## Todo:

- Better support for different types. Eg.: For dictionary return actual iteration key instead of index as a key.

## License

See more in LICENSE.md
