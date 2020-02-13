
extends 'BaseType.gd'


func _init():
	self._name = 'Any'


# Assignment check.
# Returns one of the statuses:
# OK, FAILED and CANCELED
# @param  Varian  originalValue
func check(originalValue):  # int
	return OK


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
	self._normalizedValue = originalValue
