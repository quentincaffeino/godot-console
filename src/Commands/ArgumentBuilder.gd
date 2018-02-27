
extends Object

const Argument = preload('Argument.gd')
const TypesBuilder = preload('Types/TypesBuilder.gd')
const BaseType = preload('Types/BaseType.gd')


# @param  string|null   name
# @param  int|BaseType  type
static func build(name, type = 0):  # Argument|int
	# Define arument type
	if !(typeof(type) == TYPE_OBJECT and type is BaseType):
		type = TypesBuilder.build(type if typeof(type) == TYPE_INT else 0)

	if typeof(type) == TYPE_INT:
		return FAILED

	return Argument.new(name, type)


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
