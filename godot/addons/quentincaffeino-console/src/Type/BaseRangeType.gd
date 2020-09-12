
extends 'res://addons/quentincaffeino-console/src/Type/BaseRegexCheckedType.gd'


# @var  int|float
var _minValue

# @var  int|float
var _maxValue

# @var  int|float
var _step


# @param  string     _name
# @param  int|float  minValue
# @param  int|float  maxValue
# @param  int|float  step
func _init(_name, minValue, maxValue, step).(_name, '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$'):
	self._minValue = minValue
	self._maxValue = maxValue
	self._step = step


func getMinValue():  # int|float
	return self._minValue


# @param  int|float  minValue
func setMinValue(minValue):  # BaseRange
	self._minValue = minValue
	return self


func getMaxValue():  # int|float
	return self._maxValue


# @param  int|float  maxValue
func setMaxValue(maxValue):  # BaseRange
	self._maxValue = maxValue
	return self


func getStep():  # int|float
	return self._step


# @param  int|float  step
func setStep(step):  # BaseRange
	self._step = step
	return self


func toString():  # string
	var name = self._name + '(' + str(self._minValue) + '-' + str(self._maxValue)

	if self._step != 1:
		name += ', step: ' + str(self._step)

	return name + ')'
