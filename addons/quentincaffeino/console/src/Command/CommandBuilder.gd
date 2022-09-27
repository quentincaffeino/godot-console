
extends RefCounted

const CallbackBuilder = preload('res://addons/quentincaffeino/callback/src/CallbackBuilder.gd')
const Callback = preload('res://addons/quentincaffeino/callback/src/Callback.gd')
const ArgumentFactory = preload('../Argument/ArgumentFactory.gd')
const Command = preload('Command.gd')


# @var  Console
var _console

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


# @param  Console         console
# @param  CommandService  command_service
# @param  String          name
# @param  RefCounted       target
# @param  String|null     target_name
func _init(console, command_service, name, target, target_name = null):
	self._console = console
	self._command_service = command_service

	self._name = name
	self._target = self._initialize_target_callback(target, target_name)
	self._arguments = []
	self._description = null


# @param    RefCounted    target
# @param    String|null  name
# @returns  Callback|null
func _initialize_target_callback(target, name = null):
	if target is Callback:
		return target

	name = name if name else self._name

	var callback = CallbackBuilder.new(target).set_name(name).build()

	if not callback:
		self._console.Log.error(\
			'CommandBuilder: Failed to create [b]`%s`[/b] command. Failed to create callback to target with method [b]`%s`[/b].' %
			[ self._name, name ])

	return callback


# @param    String         name
# @param    BaseType|null  type
# @param    String|null    description
# @returns  CommandBuilder
func add_argument(name, type = null, description = null):
	# @var  Result<Argument, Error>
	var argument_result = ArgumentFactory.create(name, type, description)
	var error = argument_result.get_error()
	if error:
		if error.get_code() != ArgumentFactory.FALLBACK_ERROR:
			self._console.Log.error(error.get_message())
			return self
		else:
			self._console.Log.warn(\
				"CommandBuilder: add_argument for command `%s` for argument `%s` failed with: %s" % [self._name, name, error.get_message()])

	var argument = argument_result.get_value()
	self._arguments.append(argument)
	return self


# @param    String|null  description
# @returns  CommandBuilder
func set_description(description = null):
	self._description = description
	return self


# @returns  void
func register():
	var command = Command.new(self._name, self._target, self._arguments, self._description)
	if not self._command_service.set(self._name, command):
		self._console.Log.error("CommandBuilder::register: Failed to create [b]`%s`[/b] command. Command already exists." % self._name)
