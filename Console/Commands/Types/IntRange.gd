
extends 'BaseRange.gd'


# @param  int  _min_value
# @param  int  _max_value
# @param  int  _step
func _init(_min_value = 0, _max_value = 100, _step = 1):
	_name = 'IntRange'
	_t = null

	_r = Range.new()
	_r.rounded = true;
	_r.min_value = int(_min_value)
	_r.max_value = int(_max_value)
	_r.step = int(_step)


# @param  Varian  value
func check(value):  # int
	_r.value = int(value)
	return OK
