
extends 'res://addons/quentincaffeino/console/src/Type/BaseRegexCheckedType.gd'


# @var  Vector3|null
var _normalized_value


func _init():
	super('Vector3', '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$')


# @param    Variant  value
# @returns  int
func check(value):
	var values = str(value).split(',', false, 3)
	if values.size() < 3:
		if values.size() == 2:
			values.append('0')
		elif values.size() == 1:
			values.append('0')
			values.append('0')
		else:
			return CHECK.FAILED

	# Check each number
	for i in range(2):
		if super.check(values[i]) == CHECK.FAILED:
			return CHECK.FAILED

	# Save value
	self._normalized_value = Vector3(values[0].to_float(), values[1].to_float(), values[2].to_float())

	return CHECK.OK


# @param    Variant  value
# @returns  Variant
func normalize(value):
	return self._normalized_value
