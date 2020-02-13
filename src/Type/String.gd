
extends 'Any.gd'


func _init():
	_name = 'String'
	_type = TYPE_STRING


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
	self._normalizedValue = str(originalValue)
