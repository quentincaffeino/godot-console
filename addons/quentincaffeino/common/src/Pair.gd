
extends Reference


# @var  Variant
var _key

# @var  Variant
var _value


# @param  Variant  key
# @param  Variant  value
func _init(key, value):
	self._key = key
	self._value = value


# @returns  Variant
func get_key():
	return self._key

# @returns  Variant
func get_value():
	return self._value
