
extends Reference


enum ASSIGNMENT \
{
	OK,
	FAILED,
	CANCELED
}


# @var  String
var _name

# @var  BaseType
var _type

# @var  String|null
var _description

# @var  String
var _original_value

# @var  Variant
var _normalized_value


# @param  String       name
# @param  BaseType     type
# @param  String|null  description
func _init(name, type, description = null):
	self._name = name
	self._type = type
	self._description = description


# @returns  String
func get_name():
	return self._name


# @returns  BaseType
func get_type():
	return self._type


# @returns  String
func get_value():
	return self._original_value


# @param    Variant  value
# @returns  int
func set_value(value):
	self._original_value = value

	var check = self._type.check(value)
	if check == OK:
		self._normalized_value = self._type.normalize(value)

	return check


# @returns  Variant
func get_normalized_value():
	return self._normalized_value


# @returns  String
func describe():
	return '<%s:%s>' % [self._name, self._type.to_string()]
