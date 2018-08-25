
extends 'BaseType.gd'


func _init():
  _name = 'Int'
  _type = TYPE_INT


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
  self._normalizedValue = int(_rematch.get_string())
