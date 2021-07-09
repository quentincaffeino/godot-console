
extends 'res://addons/quentincaffeino/console/src/Type/BaseRegexCheckedType.gd'


# @var  int|float
var _min_value

# @var  int|float
var _max_value

# @var  int|float
var _step


# @param  String     name
# @param  int|float  min_value
# @param  int|float  max_value
# @param  int|float  step
func _init(name, min_value, max_value, step).(name, '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$'):
	self._min_value = min_value
	self._max_value = max_value
	self._step = step


# @returns  int|float
func get_min_value():
	return self._min_value

# @param  int|float  min_value
# @returns  BaseRange
func set_min_value(min_value):
	self._min_value = min_value
	return self


# @returns  int|float
func get_max_value():
	return self._max_value

# @param  int|float  max_value
# @returns  BaseRange
func set_max_value(max_value):
	self._max_value = max_value
	return self


# @returns  int|float
func get_step():
	return self._step

# @param    int|float  step
# @returns  BaseRange
func set_step(step):
	self._step = step
	return self


# @returns  String
func to_string():
	var name = self._name + '(' + str(self._min_value) + '-' + str(self._max_value)

	if self._step != 1:
		name += ', step: ' + str(self._step)

	return name + ')'
