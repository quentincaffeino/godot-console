
extends 'BaseType.gd'


# @var  Range
var _r

# @var  int|float
var min_value setget _setMinValue, _getMinValue

# @var  int|float
var max_value setget _setMaxValue, _getMaxValue

# @var  int|float
var step setget _setStep, _getStep


func get():  # int|float
	return _r.value


func getName():  # string
	var name = _name + '(' + str(_r.min_value) + '-' + str(_r.max_value)

	if _r.step != 1:
		name += ', step: ' + str(_r.step)

	return name + ')'


# @param  int|float  value
func _setMinValue(value):  # void
	_r.min_value = value


func _getMinValue():  # int|float
	return _r.min_value


# @param  int|float  value
func _setMaxValue(value):  # void
	_r.max_value = value


func _getMaxValue():  # int|float
	return _r.max_value


# @param  int|float  value
func _setStep(value):  # void
	_r.step = value


func _getStep():  # int|float
	return _r.step
