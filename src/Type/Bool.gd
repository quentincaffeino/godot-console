
extends 'BaseType.gd'


func _init():
	_name = 'Bool'
	_type = TYPE_BOOL


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
	if _rematch.get_string() == '1' or _rematch.get_string() == 'true':
		self._normalizedValue = true
	else:
		self._normalizedValue = false
