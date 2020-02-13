
extends 'BaseRange.gd'


# @var  bool
var _rounded


# @param  int   minValue
# @param  int   maxValue
# @param  int   step
# @param  bool  rounded
func _init(minValue = 0, maxValue = 100, step = 1, rounded = true).(minValue, maxValue, step):
	self._name = 'IntRange'
	self._type = TYPE_REAL
	self.setRounded(rounded)


# Normalize variable.
# @param  Varian  originalValue
func normalize(originalValue):  # void
	var value = float(_rematch.get_string())
	value = clamp(value, self._minValue, self._maxValue)

	# Find closest step
	if self._step != 1 and value != self._minValue:
		var prevVal = self._minValue
		var curVal = self._minValue

		while curVal < value:
			prevVal = curVal
			curVal += self._step

		if curVal - value < value - prevVal and curVal <= self._maxValue:
			value = curVal
		else:
			value = prevVal

	self._normalizedValue = value


func isRounded():  # bool
	return self._rounded


# @param  bool  value
func setRounded(value):  # self
	self._rounded = (value == true)
	return self
