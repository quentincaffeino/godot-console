
extends 'BaseType.gd'


func _init():
  _name = 'Bool'
  _type = TYPE_BOOL


func get():  # bool
  if _rematch and _rematch is RegExMatch:
    var tmp = _rematch.get_string()

    return true if tmp == '1' or tmp == 'true' else false

  return false
