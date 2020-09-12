
extends 'res://addons/quentincaffeino-console/src/Type/BaseRegexCheckedType.gd'


# @var  Vector2|null
var _normalizedValue


func _init().('Vector2', '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$'):
	pass


# @param  Variant  _value
func check(_value):  # int
	var values = str(_value).split(',', false, 2)
	if values.size() < 2:
		if values.size() == 1:
			values.append('0')
		else:
			return CHECK.FAILED

	# Check each number
	for i in range(2):
		if .check(values[i]) == CHECK.FAILED:
			return CHECK.FAILED

	# Save value
	self._normalizedValue = Vector2(values[0], values[1])

	return CHECK.OK


# @param  Variant  _value
func normalize(_value):  # Variant
	return self._normalizedValue
