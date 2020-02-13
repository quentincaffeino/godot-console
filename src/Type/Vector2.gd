
extends 'BaseType.gd'


func _init():
	_name = 'Vector2'
	_type = TYPE_VECTOR2


# @param  Variant  value
func check(value):  # int
	var values = str(value).split(',', false, 2)
	if values.size() < 2:
		if values.size() == 1:
			values.append('0')
		else:
			return FAILED

	# Check each number
	var regex = Console.RegExLib.getPatternFor(TYPE_REAL)
	for i in range(2):
		if self.recheck(regex, values[i]) == FAILED:
			return FAILED

	# Save value
	self._normalizedValue = Vector2(values[0], values[1])

	return OK
