
extends 'BaseType.gd'


func _init():
  _name = 'Int'
  _type = TYPE_INT


func get():  # int
  if _rematch and _rematch is RegExMatch:
    return int(_rematch.get_string())

  return 0
