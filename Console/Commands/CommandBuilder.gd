
extends Object
const Command = preload('Command.gd')
const ArgumentB = preload('ArgumentBuilder.gd')


# @param  string  alias
# @param  Dictionary  params
static func build(alias, params):  # Command|int
	# Check target
	if !params.has('target'):
		Console.Log.error('Failed to register [b]' + alias + '[/b]. [b]Target[/b] must be an object.')
		return

	if typeof(params.target) != TYPE_OBJECT:
		Console.Log.error('Failed to register [b]' + alias + '[/b]. Missing [b]target[/b] parametr.')
		return

	# Check type
	if !params.has('type'):
		Console.Log.error('Failed to register [b]' + alias + '[/b]. Missing [b]type[/b] parametr.')
		return

	if params.type != Command.VARIABLE and params.type != Command.METHOD:
		Console.Log.error('Failed to register [b]' + alias + '[/b]. Wrong [b]type[/b].')
		return

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
				Console.Log.error('Failed to register [b]' + alias + '[/b]. Missing [b]name[/b] parametr.')
				return

		elif params.type == Command.METHOD and params.target.has_method(alias):
			params['name'] = alias

		else:
			Console.Log.error('Failed to register [b]' + alias + '[/b]. Missing [b]name[/b] parametr.')
			return

	# Set arguments
	if params.type == Command.VARIABLE and !params.has('arg'):
		Console.Log.error('Failed to register [b]' + alias + '[/b]. Missing [b]arguments[/b] parametr.')
		return

	if params.has('arg'):
		params.args = ArgumentB.buildAll([ params.arg ])
		params.erase('arg')
	elif params.has('args'):
		params.args = ArgumentB.buildAll(params.args)
	else:
		params.args = []

	if typeof(params.args) == TYPE_INT:
		Console.Log.error('Failed to register [b]' + alias + '[/b]. Wrong [b]arguments[/b] parametr.')
		return


	return Command.new(alias, params)
