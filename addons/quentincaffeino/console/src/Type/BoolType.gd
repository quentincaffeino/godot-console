
extends 'res://addons/quentincaffeino/console/src/Type/BaseType.gd'


func _init():
	super('Bool')


# @param    Variant  value
# @returns  Variant
func normalize(value):
	return value == '1' or value == 'true'
