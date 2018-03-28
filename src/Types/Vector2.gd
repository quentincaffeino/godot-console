
extends 'BaseType.gd'


# @var  Vector2|null
var _value


func _init():
  _name = 'Vector2'
  _type = TYPE_VECTOR2


# @param  Variant  value
func check(value):  # int
  var values = str(value).split(',', false)
  var values_size = values.size()
  if values_size < 2:
    if values_size == 1:
      values.append(0)
    else:
      return FAILED

  var regex = Console.RegExLib.get(TYPE_REAL)
  # Check each number
  if regex and regex is RegEx:
    for v in [0, 1]:
      _rematch = regex.search(values[v])

      if !_rematch or !(_rematch is RegExMatch):
        return FAILED

  # Save value
  _value = Vector2(values[0], values[1])

  return OK



func get():  # Vector2|null
  return _value

