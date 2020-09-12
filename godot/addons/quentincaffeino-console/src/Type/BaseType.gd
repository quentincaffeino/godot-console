
enum CHECK \
{
	OK,
	FAILED,
	CANCELED
}


# @var  string
var _name


# @param  string  name
func _init(name):
	self._name = name


# Assignment check.
# Returns one of the statuses:
# CHECK.OK, CHECK.FAILED and CHECK.CANCELED
#
# @param  Variant  _value
func check(_value) -> int:  # int
	return CHECK.OK


# Normalize variable
#
# @param  Variant  _value
func normalize(_value):  # Variant
	return _value


func toString():  # string
	return self._name
