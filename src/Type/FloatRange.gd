
extends 'BaseRange.gd'


# @param  float  minValue
# @param  float  maxValue
# @param  float  step
func _init(minValue = 0.0, maxValue = 100.0, step = 0.1).(minValue, maxValue, step):
	self._name = 'FloatRange'
	self._type = TYPE_REAL


# Normalize variable.
# @param  Variant  originalValue
func normalize(originalValue):  # void
	var value = float(_rematch.get_string())
	value = clamp(value, self._minValue, self._maxValue)

	if self._step != 0 and value != self._minValue:
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
