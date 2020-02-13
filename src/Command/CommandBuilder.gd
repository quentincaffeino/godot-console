
extends Reference

const ArgumentFactory = preload('../Argument/ArgumentFactory.gd')
const ArrayUtils = preload('../../addons/quentincaffeino-array-utils/src/Utils.gd')
const Command = preload('Command.gd')


# @var  string     name
# @var  Variant[]  parameters
static func _buildTarget(name, parameters):  # Callback|int
	var target = FAILED

	# Check target
	if !parameters.has('target') or !parameters.target:
		Console.Log.error(\
			'QC/Console/Command/Command: build: Failed to create [b]`' + \
			name + '`[/b] command. Missing [b]`target`[/b] parametr.')
		return FAILED

	if typeof(parameters.target) != TYPE_OBJECT or \
			!(parameters.target is Console.Callback):

		var targetObject = parameters.target
		if ArrayUtils.isArray(parameters.target):
			targetObject = parameters.target[0]

		var targetName = name

		if ArrayUtils.isArray(parameters.target) and \
				parameters.target.size() > 1 and \
				typeof(parameters.target[1]) == TYPE_STRING:
			targetName = parameters.target[1]
		elif parameters.has('name'):
			targetName = parameters.name

		if Console.Callback.canCreate(targetObject, targetName):
			target = Console.Callback.new(targetObject, targetName)
		else:
			target = null

	if not target or !(target is Console.Callback):
		Console.Console.Log.error(\
			'QC/Console/Command/Command: build: Failed to create [b]`' + \
			name + '`[/b] command. Failed to create callback to target')
		return FAILED

	return target


# @var  Callback     target
# @var  Variant[]  parameters
static func _buildArguments(target, parameters):  # Array<Argument>|int
	var args = []

	if target._type == Console.Callback.TYPE.VARIABLE and parameters.has('args'):
		if ArrayUtils.isArray(parameters.args) and parameters.args.size():
			# Ignore all arguments except first cause variable takes only one arg
			parameters.args = [parameters.args[0]]
		else:
			parameters.args = [parameters.args]

	if parameters.has('arg'):
		args = ArgumentFactory.createAll([ parameters.arg ])
	elif parameters.has('args'):
		args = ArgumentFactory.createAll(parameters.args)

	if typeof(args) == TYPE_INT:
		Console.Log.error(\
			'QC/Console/Command/Command: build: Failed to register [b]`' + \
			target.getName() + '`[/b] command. Wrong [b]`arguments`[/b] parametr.')
		return FAILED

	return args


# @var  string     name
# @var  Variant[]  parameters
static func build(name, parameters):  # Command|int
	var target = _buildTarget(name, parameters)
	if typeof(target) == TYPE_INT:
		return target

	var args = _buildArguments(target, parameters)
	if typeof(args) == TYPE_INT:
		return args

	var description = null
	if parameters.has('description'):
		description = parameters.description

	return Command.new(name, target, args, description)
