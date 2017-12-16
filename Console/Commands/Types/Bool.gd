
extends 'BaseType.gd'


func _init():
	_name = 'Bool'
	_t = TYPE_BOOL


func get():  # bool
	if _rematch and _rematch is RegExMatch:
		var tmp = _rematch.get_string()

		return false if tmp == '0' or tmp == 'false' else true

	return false
