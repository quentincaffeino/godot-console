
extends 'ICommand.gd'
const ArgumentB = preload('ArgumentBuilder.gd')
const Argument = preload('Argument.gd')


# @param  string  alias
# @param  Callback  target
# @param  Array<Argument>  arguments
# @param  string|null  description
func _init(alias, target, arguments, description = null):
	_alias = str(alias)
	_target = target
	_arguments = arguments

	# Set description
	_description = description
	if !description:
		Console.Log.info('No description provided for [b]' + _alias + '[/b] command')


# @param  Array  _args
func run(_args):  # int
	# Get arguments
	var args = []
	var argAssig
	for i in range(_arguments.size()):
		argAssig = _arguments[i].setValue(_args[i])

		if argAssig == FAILED:
			Console.Log.warn('Argument ' + str(i) + ': expected ' + _arguments[i]._type._name)
			return FAILED
		elif argAssig == Argument.CANCELED:
			return OK

		args.append(_arguments[i].value)

	# Execute command
	_target.call(args)

	return OK


func describe():  # void
	Console.write("[color=#ffff66][url=" + _alias + "]" + _alias + "[/url][/color]")

	if _arguments.size() > 0:
		for arg in _arguments:
			Console.write(" [color=#88ffff]" + arg.toString() + "[/color]")

	if _description:
		Console.write(' - ' + _description)

	Console.writeLine()


func requireArgs():  # int
	return _arguments.size()


func requireStrings():  # bool
	for arg in _arguments:
		if arg._type._name == 'Any' or arg._type._type == TYPE_STRING:
			return true

	return false
