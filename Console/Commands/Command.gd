
extends 'ICommand.gd'
const ArgumentB = preload('ArgumentBuilder.gd')
const Argument = preload('Argument.gd')


# @param  string  alias
# @param  Dictionary  params
func _init(alias, params):  # Command|int
	_alias = str(alias)
	_type = params.type
	_name = params.name
	_target = params.target
	_arguments = params.args

	# Set description
	if params.has('description'):
		_description = params.description
	else:
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
	if _type == VARIABLE:
		_target.set(_name, args[0])
	else:
		_target.callv(_name, args)

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
		if arg._type._name == 'Any' or arg._type._name == 'String':
			return true

	return false
