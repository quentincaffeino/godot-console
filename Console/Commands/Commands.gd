
extends 'ICommands.gd'
const CommandB = preload('CommandBuilder.gd')


# @param  string  alias
# @param  Dictionary  params
func register(alias, params):  # int
	# if has(alias):
	#   return W_COMMAND_ALREADY_EXISTS

	var command = CommandB.build(alias, params)

	if typeof(command) == TYPE_INT:
		Console.Log.error('Failed to register [b]' + alias + '[/b]. ' + Console.m.get(command, 'Command'))
		return FAILED

	_commands[alias] = command

	return OK


# @param  string  alias
func deregister(alias):  # void
	if has(alias):
		_commands.erase(alias)


# @param  string  alias
func get(alias):  # Command
	if has(alias):
		return _commands[alias]

	# Try autocomplete
	var foundArr = []
	for command in _commands:
		if command.begins_with(alias):
			foundArr.append(_commands[command])

	if foundArr.size() > 0:
		return foundArr


# @param  string  alias
func has(alias):  # bool
	return _commands.has(alias)


func printAll():  # void
	for command in _commands:
		_commands[command].describe()
