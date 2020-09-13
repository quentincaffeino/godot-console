
extends 'res://addons/quentincaffeino-console/src/Type/BaseType.gd'


# @var  String
var _pattern

# @var  RegEx
var _regex


# @param  String  name
# @param  String  pattern
func _init(name, pattern).(name):
	self._pattern = pattern
	self._regex = RegEx.new()
	self._regex.compile(self._pattern)


# @param    Variant  value
# @returns  int
func check(value):
	return CHECK.OK if self._reextract(value) else CHECK.FAILED


# @param    Variant  value
# @returns  String|null
func _reextract(value):
	var rematch = self._regex.search(value)

	if rematch and rematch is RegExMatch:
		return rematch.get_string()

	return null
