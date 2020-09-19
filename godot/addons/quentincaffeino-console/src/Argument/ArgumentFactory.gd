
extends Reference

const Argument = preload('../Argument/Argument.gd')
const TypeFactory = preload('../Type/TypeFactory.gd')
const BaseType = preload('../Type/BaseType.gd')
const Result = preload('../Misc/Result.gd')
const Error = preload('../Misc/Error.gd')


const FALLBACK_ERROR = '73ca5439-fd62-442f-8a33-73135dbf5469'


# @param    String        name
# @param    int|BaseType  type
# @param    String|null   description
# @returns  Result
static func create(name, type = 0, description = null):
	var error_message

	# Define argument type
	if typeof(type) == TYPE_INT:
		var type_result = TypeFactory.create(type)

		if type_result.has_error():
			error_message = "%s Falling back to `Any` type." % type_result.get_error().get_message()
			type = TypeFactory.create(0).get_value()
		else:
			type = type_result.get_value()

	if not type is BaseType:
		return Result.new(null, "Second argument (type) must extend BaseType. If you want to use custom types please refer to the documentation for more info.")

	var error
	if error_message:
		error = Error.new(error_message, FALLBACK_ERROR)

	return Result.new(Argument.new(name, type, description), error)
