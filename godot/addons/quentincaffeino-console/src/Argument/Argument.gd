
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
var _originalValue

# @var  Variant
var _normalizedValue


# @param  String       name
# @param  BaseType     type
# @param  String|null  description
func _init(name, type, description = null):
	self._name = name
	self._type = type
	self._description = description


# @returns  String
func getValue():
	return self._originalValue


# @param    Variant  value
# @returns  int
func setValue(value):
	self._originalValue = value

	var check = self._type.check(value)
	if check == OK:
		self._normalizedValue = self._type.normalize(value)

	return check


# @returns  Variant
func getNormalizedValue():
	return self._normalizedValue


# @returns  String
func describe():
	return '<%s:%s>' % [self._name, self._type.toString()]


# @returns  String
func getName():
	return self._name


# @returns  BaseType
func getType():
	return self._type
