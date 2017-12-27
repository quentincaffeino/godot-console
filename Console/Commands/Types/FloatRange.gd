
extends 'BaseRange.gd'


# @param  float  _minValue
# @param  float  _maxValue
# @param  float  _step
func _init(_minValue = 0, _maxValue = 100, _step = 0):
	_name = 'FloatRange'
	minValue = float(_minValue)
	maxValue = float(_maxValue)
	step = float(_step)


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
