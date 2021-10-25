
const Error = preload("./Error.gd")


# @var  Variant
var _value

# @var  Variant
var _error


# @param  Variant  value
# @param  Variant  error
func _init(value, error = null):
	self._value = value

	if error is String:
		error = self.get_script().create_error(error)

	self._error = error


# @returns Variant
func get_value():
	return self._value


# @returns  Variant
func get_error():
	return self._error

# @returns  bool
func has_error():
	return !!self._error


# @param    String  message
# @returns  Error
static func create_error(message):
	return Error.new(message)
