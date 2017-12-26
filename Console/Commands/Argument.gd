
extends 'IArgument.gd'
const TypesBuilder = preload('Types/TypesBuilder.gd')
const BaseType = preload('Types/BaseType.gd')


# @param  string|null  name
# @param  BaseType  type
func _init(name, type):
	_name = name
	_type = type


# @param  Variant  _value
func setValue(_value):  # int
	return _type.check(_value)


func getValue():  # Variant
	return _type.get()


func toString():  # string
	var result = ''

	if _name:
		result += _name + ':'

	result += _type.getName()

	return result
