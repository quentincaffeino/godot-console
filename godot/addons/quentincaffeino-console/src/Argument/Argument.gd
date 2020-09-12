
extends Reference


enum ASSIGNMENT \
{
	OK,
	FAILED,
	CANCELED
}


# @var  string
var _name

# @var  BaseType
var _type

# @var  string|null
var _description

# @var  string
var _originalValue

# @var  Variant
var _normalizedValue


# @param  string       name
# @param  BaseType     type
# @param  string|null  description
func _init(name, type, description = null):
	self._name = name
	self._type = type
	self._description = description


func getValue():  # string
	return self._originalValue


# @param  Variant  value
func setValue(value):  # int
	self._originalValue = value

	var check = self._type.check(value)
	if check == OK:
		self._normalizedValue = self._type.normalize(value)

	return check


func getNormalizedValue():  # Variant
	return self._normalizedValue


func describe():  # string
	return self._name + ':' + self._type.toString()


func getName():  # string
	return self._name


func getType():  # BaseType
	return self._type
