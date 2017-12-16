
extends 'IBaseType.gd'


# @param  Varian  value
func check(value):  # int
	_rematch = Console.RegExLib.get(_t)

	if _rematch and _rematch is RegEx:
		_rematch = _rematch.search(value)

		if _rematch and _rematch is RegExMatch:
			return OK

	return FAILED


func getName():  # string
	return _name
