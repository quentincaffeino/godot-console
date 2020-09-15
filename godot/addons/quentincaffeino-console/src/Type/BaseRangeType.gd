
extends 'res://addons/quentincaffeino-console/src/Type/BaseRegexCheckedType.gd'


# @var  int|float
var _minValue

# @var  int|float
var _maxValue

# @var  int|float
var _step


# @param  String     name
# @param  int|float  minValue
# @param  int|float  maxValue
# @param  int|float  step
func _init(name, minValue, maxValue, step).(name, '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$'):
	self._minValue = minValue
	self._maxValue = maxValue
	self._step = step


# @returns  int|float
func getMinValue():
	return self._minValue


# @param  int|float  minValue
# @returns  BaseRange
func setMinValue(minValue):
	self._minValue = minValue
	return self


# @returns  int|float
func getMaxValue():
	return self._maxValue


# @param  int|float  maxValue
# @returns  BaseRange
func setMaxValue(maxValue):
	self._maxValue = maxValue
	return self


# @returns  int|float
func getStep():
	return self._step


# @param    int|float  step
# @returns  BaseRange
func setStep(step):
	self._step = step
	return self


# @returns  String
func toString():
	var name = self._name + '(' + str(self._minValue) + '-' + str(self._maxValue)

	if self._step != 1:
		name += ', step: ' + str(self._step)

	return name + ')'
