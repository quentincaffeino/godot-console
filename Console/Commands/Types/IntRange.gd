
extends 'BaseRange.gd'


# @var  bool
var rounded = true setget _setRounded


# @param  int  _minValue
# @param  int  _maxValue
# @param  int  _step
func _init(_minValue = 0, _maxValue = 100, _step = 1):
	_name = 'IntRange'
	minValue = int(_minValue)
	maxValue = int(_maxValue)
	step = int(_step)


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
