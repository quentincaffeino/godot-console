
# @var  String
var _message

# @var  int
var _code


# @param  String  message
# @param  int     code
func _init(message, code = null):
  self._message = message
  self._code = code


# @returns  String
func get_message():
  return self._message


# @returns  int
func get_code():
  return self._code


# @returns  String
func to_string():
  return self._message
