
extends 'BaseType.gd'


# @var  Variant
var _value


func _init():
  _name = 'Any'


# @param  Varian  value
func check(value):  # int
  _value = value
  return OK


func fetch():  # Variant
  return _value
