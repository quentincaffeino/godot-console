
extends 'BaseRange.gd'


# @param  float  inMinValue
# @param  float  inMaxValue
# @param  float  inStep
func _init(inMinValue = 0, inMaxValue = 100, inStep = 0):
  _name = 'FloatRange'
  minValue = float(inMinValue)
  maxValue = float(inMaxValue)
  step = float(inStep)


# @param  Varian  value
func check(value):  # int
  value = clamp(float(value), minValue, maxValue)

  # Find closest step
  if step != 0 and value != minValue:
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
