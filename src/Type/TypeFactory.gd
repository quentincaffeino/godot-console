
extends Reference


const TypeList = [
	preload('Any.gd'),
	preload('Bool.gd'),
	preload('Int.gd'),
	preload('Float.gd'),
	preload('String.gd'),
	preload('Vector2.gd'),
	null,  # Rect2
	preload('Vector3.gd'),
]


# @private
# @param  int  type
static func _typeConstToTypeListIndex(type):  # BaseType
	if type >= 0 and type < TypeList.size() and TypeList[type] != null:
		return type
	else:
		return 0


# @param  int  type
static func create(type):  # BaseType
	return TypeList[_typeConstToTypeListIndex(type)].new()
