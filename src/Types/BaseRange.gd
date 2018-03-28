
extends 'BaseType.gd'


# @var  int|float
var _value

# @var  int|float
var minValue

# @var  int|float
var maxValue

# @var  int|float
var step


func get():  # int|float
  return _value


func getName():  # string
  var name = _name + '(' + str(minValue) + '-' + str(maxValue)

  if step != 1:
    name += ', step: ' + str(step)

  return name + ')'
