
extends Object
const Command = preload('Command.gd')
const ArgumentB = preload('ArgumentBuilder.gd')


# @param  string  alias
# @param  Dictionary  params
static func build(alias, params):  # Command|int
	# Check target
	if !params.has('target'):
		return Command.E_NO_TARGET

	# Check type
	if !params.has('type'):
		return Command.E_NO_TYPE

	if params.type != Command.VARIABLE and params.type != Command.METHOD:
		return Command.E_WRONG_TYPE

	# Check name
	if !params.has('name'):
		if params.type == Command.VARIABLE:
			var properties = params.target.get_property_list()

			var hasProp = false

			for prop in properties:
				if prop.name == alias:
					hasProp = true

			if hasProp:
				params['name'] = alias
			else:
				return Command.E_NO_NAME

		elif params.type == Command.METHOD and params.target.has_method(alias):
			params['name'] = alias

		else:
			return Command.E_NO_NAME

	# Set arguments
	if params.type == Command.VARIABLE and !params.has('arg'):
		return Command.E_NO_ARGUMENTS

	if params.has('arg'):
		params.args = ArgumentB.buildAll([ params.arg ])
		params.erase('arg')
	elif params.has('args'):
		params.args = ArgumentB.buildAll(params.args)
	else:
		params.args = []

	if typeof(params.args) == TYPE_INT:
		return Command.E_WRONG_ARGUMENT


	return Command.new(alias, params)
