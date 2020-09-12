
extends 'res://addons/quentincaffeino-console/src/Type/BaseType.gd'


func _init().('Bool'):
	pass


# @param  Variant  _value
func normalize(_value):  # Variant
	return _value == '1' or _value == 'true'
