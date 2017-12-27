
extends Object
const Argument = preload('Argument.gd')
const TypesBuilder = preload('Types/TypesBuilder.gd')
const BaseType = preload('Types/BaseType.gd')


# @param  string|null  _name
# @param  int|BaseType  _type
static func build(_name, _type = 0):  # Argument|int
	# Define arument type
	var type
	if typeof(_type) == TYPE_OBJECT and _type is BaseType:
		type = _type
	else:
		type = TypesBuilder.build(_type if typeof(_type) == TYPE_INT else 0)

	if typeof(type) == TYPE_INT:
		return FAILED

	return Argument.new(_name, type)


# @param  Array  args
static func buildAll(args):  # Array<Argument>|int
	var builtArgs = []

	var tArg
	for arg in args:
		match typeof(arg):
			TYPE_ARRAY:            tArg = build(arg[0], arg[1] if arg.size() > 1 else 0)
			TYPE_STRING:           tArg = build(arg)
			TYPE_OBJECT, TYPE_INT: tArg = build(null, arg)

		if typeof(tArg) == TYPE_INT:
			return FAILED

		builtArgs.append(tArg)

	return builtArgs
