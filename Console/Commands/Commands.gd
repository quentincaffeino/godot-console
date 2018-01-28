
extends 'ICommands.gd'

const CommandB = preload('CommandBuilder.gd')


# @param  string  alias
# @param  Dictionary  params
func register(alias, params):  # int
	# Check if already exists
	if has(alias):
		Console.Log.warn('Failed to register [b]' + \
			alias + '[/b]. Command already exists.', 'Commands: register')
		return FAILED

	# Register command
	var command = CommandB.build(alias, params)

	if command:
		_commands[alias] = command
		return OK

	return FAILED


# @param  string  alias
func unregister(alias):  # int
	if !has(alias):
		Console.Log.info('Tried to unregister nonexistent command [b]' + \
			alias + '[/b].', 'Commands: unregister')
		return FAILED
	
	_commands.erase(alias)
	return OK


# @param  string  alias
func get(alias):  # Command
	if has(alias):
		return _commands[alias]

	# Try autocomplete
	for command in _commands:
		if command.begins_with(alias):
			return _commands[command]


# @param  string  alias
func has(alias):  # bool
	return _commands.has(alias)


func printAll():  # void
	for command in _commands:
		_commands[command].describe()
