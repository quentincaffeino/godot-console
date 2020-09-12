
extends Reference

const Argument = preload('../Argument/Argument.gd')
const TypeFactory = preload('../Type/TypeFactory.gd')
const BaseType = preload('../Type/BaseType.gd')


# @param  string        name
# @param  int|BaseType  type
# @param  string|null   description
static func create(name, type = 0, description = null):  # Argument|int
	# Define argument type
	if !(typeof(type) == TYPE_OBJECT and type is BaseType):
		type = TypeFactory.create(type if typeof(type) == TYPE_INT else 0)

	if not type is BaseType:
		Console.Log.error(\
			'QC/Console/Command/Argument: build: Argument of type [b]' + str(type) + '[/b] isn\'t supported.')
		return FAILED

	return Argument.new(name, type, description)


# @param  Array<Variant>  args
static func createAll(args):  # Array<Argument>|int
	# @var  Array<Argument>|int  builtArgs
	var builtArgs = []

	# @var  Argument|int|null  tempArg
	var tempArg
	for arg in args:
		tempArg = null

		match typeof(arg):
			# [ 'argName', BaseType|ARG_TYPE ]
			TYPE_ARRAY:
				tempArg = create(arg[0], arg[1] if arg.size() > 1 else 0)

			# 'argName'
			TYPE_STRING:
				tempArg = create(arg)

			# BaseType|ARG_TYPE
			TYPE_OBJECT, TYPE_INT:
				tempArg = create(null, arg)

		if typeof(tempArg) == TYPE_INT:
			return FAILED

		builtArgs.append(tempArg)

	return builtArgs
