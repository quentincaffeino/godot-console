
const TYPE_LIST = [
	preload('AnyType.gd'),
	preload('BoolType.gd'),
	preload('IntType.gd'),
	preload('FloatType.gd'),
	preload('StringType.gd'),
	preload('Vector2Type.gd'),
	null,  # Rect2
	preload('Vector3Type.gd'),
]


# @param    int  type
# @returns  BaseType
static func _typeConstToTypeListIndex(type):
	if type >= 0 and type < TYPE_LIST.size() and TYPE_LIST[type] != null:
		return type
	else:
		Console.warn('Unable to initialize type')
		return 0


# @param    int  type
# @returns  BaseType
static func create(type):
	return TYPE_LIST[_typeConstToTypeListIndex(type)].new()
