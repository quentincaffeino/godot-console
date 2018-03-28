
extends Reference

const Command = preload('Command/Command.gd')


# @var  CommandAutocomplete
var Autocomplete = preload('Command/CommandAutocomplete.gd').new() setget _setProtected

# @var  Dictionary
var _commands = {}


# @param  string      alias
# @param  Dictionary  params
func register(alias, params):  # int
  # Check if already exists
  if has(alias):
    Console.Log.warn('Failed to register [b]' + \
      alias + '[/b]. Command already exists.', 'Commands: register')
    return FAILED

  # Register command
  var command = Command.build(alias, params)

  if command:
    _commands[alias] = command
    return OK

  return FAILED


# @param  string  alias
func unregister(alias):  # int
  if !has(alias):
    Console.Log.info('Attempt to unregister nonexistent command [b]' + \
      alias + '[/b].', 'Commands: unregister')
    return FAILED
  
  _commands.erase(alias)
  return OK


# @param  string  alias
func get(alias):  # Command
  if has(alias):
    return _commands[alias]

  if Console.submitAutocomplete:
    # Try autocomplete
    var filteredCommands = []

    for command in _commands:
      if command.begins_with(alias):
        filteredCommands.append(command)

    if filteredCommands.size() == 1:
      return _commands[filteredCommands[0]]


# @param  string  alias
func has(alias):  # bool
  return _commands.has(alias)


func printAll():  # void
  for command in _commands:
    _commands[command].describe()


func _setProtected(value):  # void
  Console.Log.warn('Trying to set a protected variable, ignoring. Provided ' + str(value), \
    'Commands')
