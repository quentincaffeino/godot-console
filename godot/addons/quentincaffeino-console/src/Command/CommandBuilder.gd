
extends Reference

const ArgumentFactory = preload('../Argument/ArgumentFactory.gd')
const ArrayUtils = preload('../../addons/quentincaffeino-array-utils/src/Utils.gd')
const Command = preload('Command.gd')


# @var  string
var _name

# @var  Callback|null
var _target

# @var  Argument[]
var _arguments

# @var  string|null
var _description

# @var  CommandGroup
var _commandGroup


# @param  CommandGroup  commandGroup
# @param  string        name
# @param  Reference     target
# @param  string|null   targetName
func _init(commandGroup, name, target, targetName = null):
	self._name = name
	self._target = self._createTarget(target, targetName)
	self._arguments = []
	self._description = null
	self._commandGroup = commandGroup


# @private
# @param  Reference    target
# @param  string|null  name
func _createTarget(target, name = null):  # Callback|null
	var callback = Console.CallbackBuilder.new(target).setName(name if name else self._name).build()

	if not callback:
		Console.Log.error(\
			'QC/Console/Command/CommandBuilder: setTarget: Failed to create [b]`' + \
			(name if name else self._name) + '`[/b] command. Failed to create callback to target.')

	return callback


# @param  string         name
# @param  BaseType|null  type
# @param  string|null    description
func addArgument(name, type = null, description = null):  # CommandBuilder
	self._arguments.append(ArgumentFactory.create(name, type, description))
	return self


# @param  string|null  description
func setDescription(description = null):  # CommandBuilder
	self._description = description
	return self


func register():  # void
	# TODO: Rewrite using CommandGroup public methods
	var command = Command.new(self._name, self._target, self._arguments, self._description)
	var nameParts = self._name.split('.', false)
	var lastNamePart = nameParts[nameParts.size() - 1]
	var group = self._commandGroup
	if nameParts.size() > 1:
		group = self._commandGroup._getGroup(nameParts, true)
	group.getCommands().set(lastNamePart, command)


# @deprecated
# @private
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


# @deprecated
# @private
# @var  Callback   target
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


# @deprecated
# @var  string     name
# @var  Variant[]  parameters
static func buildDeprecated(name, parameters):  # Command|int
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
