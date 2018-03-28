
extends 'BaseRange.gd'


# @var  bool
var rounded = true setget _setRounded


# @param  int  inMinValue
# @param  int  inMaxValue
# @param  int  inStep
func _init(inMinValue = 0, inMaxValue = 100, inStep = 1):
  _name = 'IntRange'
  minValue = int(inMinValue)
  maxValue = int(inMaxValue)
  step = int(inStep)


# @param  Varian  value
func check(value):  # int
  value = clamp(int(value), minValue, maxValue)

  # Find closest step
  if step != 1 and value != minValue:
    var prevVal = minValue
    var curVal = minValue

    while curVal < value:
      prevVal = curVal
      curVal += step

    if curVal - value < value - prevVal and curVal <= maxValue:
      _value = curVal
    else:
      _value = prevVal

  return OK


# @param  bool  value
func _setRounded(value):
  rounded = (value == true)
