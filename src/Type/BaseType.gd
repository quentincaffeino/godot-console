
extends Reference


enum CHECK \
{
	OK,
	FAILED,
	CANCELED
}


# @var  string
var _name

# @var  int
var _type = -1

# @var  RegExMatch
var _rematch

# @var  Variant
var _normalizedValue


# Assignment check.
# Returns one of the statuses:
# OK, FAILED and CANCELED
# @param  Varian  originalValue
func check(originalValue):  # int
	var regex = Console.RegExLib.getPatternFor(_type)
	return self.recheck(regex, originalValue)


# @param  RegEx   regex
# @param  Varian  value
func recheck(regex, value):
	if regex and regex is RegEx:
		_rematch = regex.search(value)

		if _rematch and _rematch is RegExMatch:
			return CHECK.OK

	return CHECK.FAILED


# Normalize variable
# @param  Varian  originalValue
func normalize(originalValue):  # void
	pass


func getNormalizedValue():  # Variant
	return self._normalizedValue


func toString():  # string
	return self._name
