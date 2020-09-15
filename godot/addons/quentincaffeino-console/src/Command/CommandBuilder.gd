
extends Reference

const ArrayUtils = preload('../../addons/quentincaffeino-array-utils/src/Utils.gd')
const CallbackBuilder = preload('../../addons/quentincaffeino-callback/src/CallbackBuilder.gd')
const CallbackUtils = preload('../../addons/quentincaffeino-callback/src/Utils.gd')
const ArgumentFactory = preload('../Argument/ArgumentFactory.gd')
const Command = preload('Command.gd')


# @var  CommandService
var _command_service

# @var  String
var _name

# @var  Callback|null
var _target

# @var  Argument[]
var _arguments

# @var  String|null
var _description


# @param  CommandService  command_service
# @param  String          name
# @param  Reference       target
# @param  String|null     targetName
func _init(command_service, name, target, targetName = null):
	self._name = name
	self._target = self._createTarget(target, targetName)
	self._arguments = []
	self._description = null
	self._command_service = command_service


# @param    Reference    target
# @param    String|null  name
# @returns  Callback|null
func _createTarget(target, name = null):
	name = name if name else self._name

	var callback = CallbackBuilder.new(target)\
		.setName(name)\
		.build()

	if not callback:
		Console.Log.error(\
			'QC/Console/Command/CommandBuilder: setTarget: Failed to create [b]`%s`[/b] command. Failed to create callback to target with method [b]`%s`[/b].' %
			[ self._name, name ])

	return callback


# @param    String         name
# @param    BaseType|null  type
# @param    String|null    description
# @returns  CommandBuilder
func addArgument(name, type = null, description = null):
	self._arguments.append(ArgumentFactory.create(name, type, description))
	return self


# @param    String|null  description
# @returns  CommandBuilder
func setDescription(description = null):
	self._description = description
	return self


# @returns  void
func register():
	var command = Command.new(self._name, self._target, self._arguments, self._description)
	if not self._command_service.set(self._name, command):
		Console.Log.error('QC/Console/Command/CommandBuilder: register: Failed to create [b]`%s`[/b] command. Command already exists.')
