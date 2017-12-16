
extends Object


const TypesList = {
	'0': preload('Any.gd'),
	'1': preload('Bool.gd'),
	'2': preload('Int.gd'),
	'3': preload('Float.gd'),
	'4': preload('String.gd'),
}


# @param  int  _type
static func build(_type):  # BaseType|int
	var str_type = str(_type)

	if (TypesList.has(str_type)):
		return TypesList[str_type].new()

	return FAILED
