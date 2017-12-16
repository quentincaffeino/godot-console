
extends 'BaseRange.gd'


# @param  float  _min_value
# @param  float  _max_value
# @param  float  _step
func _init(_min_value = 0.0, _max_value = 100.0, _step = 1.0):
	_name = 'FloatRange'
	_t = null

	_r = Range.new()
	_r.rounded = false;
	_r.min_value = float(_min_value)
	_r.max_value = float(_max_value)
	_r.step = float(_step)


# @param  Varian  value
func check(value):  # float
	_r.value = float(value)
	return OK
