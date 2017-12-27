
extends Object


const TypesList = [
	preload('Any.gd'),
	preload('Bool.gd'),
	preload('Int.gd'),
	preload('Float.gd'),
	preload('String.gd'),
]


# @param  int  type
static func build(type):  # BaseType
	return TypesList[type if type < TypesList.size() else 0].new()
