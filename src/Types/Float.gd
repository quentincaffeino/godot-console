
extends 'BaseType.gd'


func _init():
  _name = 'Float'
  _type = TYPE_REAL


func getValue():  # float
  if _rematch and _rematch is RegExMatch:
    return float(_rematch.get_string().replace(',', '.'))

  return 0.0
