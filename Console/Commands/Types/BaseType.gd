
extends 'IBaseType.gd'


# @param  Varian  value
func check(value):  # int
	var regex = Console.RegExLib.get(_t)

	if regex is RegEx:
		_rematch = regex.search(value)

		if _rematch and _rematch is RegExMatch:
			return OK

	return FAILED


func getName():  # string
	return _name
