
const Result = preload('../Misc/Result.gd')


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
# @returns  Result<int, Error>
static func _type_const_to_type_list_index(type):
	if type >= 0 and type < TYPE_LIST.size() and TYPE_LIST[type] != null:
		return Result.new(type)
	else:
		return Result.new(null, \
			'Type `%s` is not supported by console, please rerer to the documentation to obtain full list of supported engine types.' % int(type))


# @param    int  engine_type
# @returns  Result<BaseType, Error>
static func create(engine_type):
	if typeof(engine_type) != TYPE_INT:
		return Result.new(null, "First argument (engine_type) must be of type int, `%s` type provided." % typeof(engine_type))

	var engine_type_result = _type_const_to_type_list_index(engine_type)

	if engine_type_result.has_error():
		return engine_type_result

	return Result.new(TYPE_LIST[engine_type_result.get_value()].new())
