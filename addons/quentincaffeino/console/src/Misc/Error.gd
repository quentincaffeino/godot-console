
# @var  String
var _message

# @var  Variant|null
var _code


# @param  String        message
# @param  Variant|null  code
func _init(message, code = null):
  self._message = message
  self._code = code


# @returns  String
func get_message():
  return self._message


# @returns  Variant|null
func get_code():
  return self._code


# @returns  String
func to_string():
  return self._message
