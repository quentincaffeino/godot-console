
extends 'BaseType.gd'


func _init():
	_name = 'Float'
	_type = TYPE_REAL


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
	self._normalizedValue = float(_rematch.get_string().replace(',', '.'))
