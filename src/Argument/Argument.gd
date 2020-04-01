
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


# @param  string       name
# @param  BaseType     type
# @param  string|null  description
func _init(name, type, description = null):
	self._name = name
	self._type = type
	self._description = description


func getValue():  # Variant
	return self._type.getNormalizedValue()


# @param  Variant  value
func setValue(value):  # int
	self._originalValue = value

	var check = self._type.check(value)
	if check == OK:
		self._type.normalize(value)

	return check


func getOriginalValue():
	return self._originalValue


func describe():  # string
	var argumentName = ''

	if self._name:
		argumentName += self._name + ':'

	argumentName += self._type.toString()

	return argumentName


func getName():  # string
	return self._name


func getType():  # BaseType
	return self._type
