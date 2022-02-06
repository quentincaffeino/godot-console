
extends Reference


# @var  Variant|null
var _value


# @param  Variant  value
# @param  Variant  error
func _init(value):
	self._value = value


# @returns  Variant
func get_value():
	assert(self.is_present())
	return self._value

# @returns  bool
func is_present():
	return !!self._value
