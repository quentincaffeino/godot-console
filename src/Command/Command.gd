
extends Reference

const Argument = preload('../Argument/Argument.gd')


# @var  string
var _alias

# @var  Callback
var _target

# @var  Array<Argument>
var _arguments = []

# @var  string|null
var _description


# @param  string           alias
# @param  Callback         target
# @param  Array<Argument>  arguments
# @param  string|null      description
func _init(alias, target, arguments, description = null):
  _alias = str(alias)
  _target = target
  _arguments = arguments

  # Set description
  _description = description
  if !description:
    Console.Log.info('No description provided for [b]' + _alias + '[/b] command', \
      'Command: _init')


# @param  Array  inArgs
func run(inArgs):  # int
  # Get arguments
  var args = []
  var argAssig
  for i in range(_arguments.size()):
    argAssig = _arguments[i].setValue(inArgs[i])

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


# @param  string      alias
# @param  Dictionary  params
static func build(alias, params):  # Command
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
  if params.target._type == Console.Callback.VARIABLE and params.has('args'):
    # Ignore all arguments except first cause variable takes only one arg
    params.args = [params.args[0]]

  if params.has('arg'):
    params.args = Argument.buildAll([ params.arg ])
    params.erase('arg')
  elif params.has('args'):
    params.args = Argument.buildAll(params.args)
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

  return new(alias, params.target, params.args, params.description)
