
enum CHECK \
{
	OK,
	FAILED,
	CANCELED
}


# @var  String
var _name


# @param  String  name
func _init(name):
	self._name = name


# Assignment check.
# Returns one of the statuses:
# CHECK.OK, CHECK.FAILED and CHECK.CANCELED
# @param    Variant  value
# @returns  int
func check(value):
	return CHECK.OK


# Normalize variable
# @param    Variant  value
# @returns  Variant
func normalize(value):
	return value


# @returns  String
func to_string():
	return self._name
