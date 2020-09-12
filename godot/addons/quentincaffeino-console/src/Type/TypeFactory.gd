
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


# @private
# @param  int  type
static func _typeConstToTypeListIndex(type):  # BaseType
	if type >= 0 and type < TYPE_LIST.size() and TYPE_LIST[type] != null:
		return type
	else:
		Console.warn('Unable to initialize type')
		return 0


# @param  int  type
static func create(type):  # BaseType
	return TYPE_LIST[_typeConstToTypeListIndex(type)].new()
