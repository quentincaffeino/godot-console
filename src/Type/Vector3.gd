
extends 'BaseType.gd'


func _init():
	_name = 'Vector3'
	_type = TYPE_VECTOR3


# @param  Variant  value
func check(value):  # int
	var values = str(value).split(',', false, 3)
	if values.size() < 3:
		if values.size() == 2:
			values.append('0')
			values.append('0')
		elif values.size() == 1:
			values.append('0')
		else:
			return FAILED

	# Check each number
	var regex = Console.RegExLib.getPatternFor(TYPE_REAL)
	for i in range(3):
		if self.recheck(regex, values[i]) == FAILED:
			return FAILED

	# Save value
	self._normalizedValue = Vector3(values[0], values[1], values[2])

	return OK
