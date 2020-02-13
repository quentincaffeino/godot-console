
extends 'BaseType.gd'


func _init():
	self._name = 'Int'
	self._type = TYPE_INT


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
	self._normalizedValue = int(_rematch.get_string())
	Console.Log.warn([originalValue, self._normalizedValue])
