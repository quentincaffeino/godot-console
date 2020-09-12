
extends 'res://addons/quentincaffeino-console/src/Type/BaseType.gd'


# @var  string
var _pattern

# @var  RegEx
var _regex


# @param  string  name
# @param  string  pattern
func _init(name, pattern).(name):
	self._pattern = pattern
	self._regex = RegEx.new()
	self._regex.compile(self._pattern)


# @param  Variant  value
func check(value):  # int
	return CHECK.OK if self._reextract(value) else CHECK.FAILED


# @param  Variant  value
func _reextract(value):  # string|null
	var rematch = self._regex.search(value)

	if rematch and rematch is RegExMatch:
		return rematch.get_string()

	return null
