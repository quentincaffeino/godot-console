
extends Reference

const Command = preload('Command/Command.gd')
const TypesBuilder = preload('Types/TypesBuilder.gd')
const BaseType = preload('Types/BaseType.gd')
const Argument = preload('Argument/Argument.gd')

# @var  CommandAutocomplete
var Autocomplete = preload('Command/CommandAutocomplete.gd').new() setget _setProtected

# @var  Dictionary
var _commands = {}

# @param  string|null   name
# @param  int|BaseType  type
static func build_argument(name, type = 0):  # Argument|int
  # Define arument type
  if !(typeof(type) == TYPE_OBJECT and type is BaseType):
    type = TypesBuilder.build(type if typeof(type) == TYPE_INT else 0)

  if typeof(type) == TYPE_INT:
    return FAILED

  return Argument.new(name, type)


# @param  Array  args
static func build_arguments(args):  # Array<Argument>|int
  var builtArgs = []

  var tArg
  for arg in args:
    match typeof(arg):
      TYPE_ARRAY:            tArg = build_argument(arg[0], arg[1] if arg.size() > 1 else 0)
      TYPE_STRING:           tArg = build_argument(arg)
      TYPE_OBJECT, TYPE_INT: tArg = build_argument(null, arg)

    if typeof(tArg) == TYPE_INT:
      return FAILED

    builtArgs.append(tArg)

  return builtArgs

# @param  string      alias
# @param  Dictionary  params
static func build_command(alias, params):  # Command
  # Warn
  if params.has('type'):
    Console.Log.warn(\
      'Using deprecated argument [b]type[/b] in [b]' + alias + '[/b].', \
      'CommandBuilder: build')
  if params.has('name'):
    Console.Log.warn(\
      'Using deprecated argument [b]name[/b] in [b]' + alias + '[/b].', \
      'CommandBuilder: build')

  # Check target
  if !params.has('target') or !params.target:
    Console.Log.error(\
      'Failed to register [b]' + alias + '[/b] command. Missing [b]target[/b] parametr.', \
      'CommandBuilder: build')
    return

  # Create target if old style used
  if typeof(params.target) != TYPE_OBJECT or \
      !(params.target is Console.Callback):

    var target = params.target
    if typeof(params.target) == TYPE_ARRAY:
      target = params.target[0]

    var name = alias

    if typeof(params.target) == TYPE_ARRAY and \
        params.target.size() > 1 and \
        typeof(params.target[1]) == TYPE_STRING:
      name = params.target[1]
    elif params.has('name'):
      name = params.name

    if Console.Callback.canCreate(target, name):
      params.target = Console.Callback.new(target, name)
    else:
      params.target = null

  if params.target:
    if not params.target is Console.Callback:
      Console.Log.error(\
        'Failed to register [b]' + alias + \
          '[/b] command. Failed to create callback to target', \
        'CommandBuilder: build')
      return
  else:
    Console.Log.error(\
      'Failed to register [b]' + alias + \
        '[/b] command. Failed to create callback to target', \
      'CommandBuilder: build')
    return

  # Set arguments
  if params.target._type == Console.Callback.TYPE.VARIABLE and params.has('args'):
    # Ignore all arguments except first cause variable takes only one arg
    params.args = [params.args[0]]

  if params.has('arg'):
    params.args = build_arguments([ params.arg ])
    params.erase('arg')
  elif params.has('args'):
    params.args = build_arguments(params.args)
  else:
    params.args = []

  if typeof(params.args) == TYPE_INT:
    Console.Log.error(\
      'Failed to register [b]' + alias + \
        '[/b] command. Wrong [b]arguments[/b] parametr.', \
      'CommandBuilder: build')
    return

  if !params.has('description'):
    params.description = null

  return Command.new(alias, params.target, params.args, params.description)

# @param  string      alias
# @param  Dictionary  params
func register(alias, params):  # int
  # Check if already exists
  if has(alias):
    Console.Log.warn('Failed to register [b]' + \
      alias + '[/b]. Command already exists.', 'Commands: register')
    return FAILED

  # Register command
  var command = build_command(alias, params)

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
