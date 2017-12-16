
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
	var setCheck = _type.check(_value)

	if setCheck == OK:
		value = _type.get()

	return setCheck


func toString():  # string
	var result = ''

	if _name:
		result += _name + ':'

	result += _type.getName()

	return result
