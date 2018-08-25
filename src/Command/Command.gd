
extends Reference

const Argument = preload('Argument.gd')


# @var  string
var _name

# @var  Callback
var _target

# @var  Argument[]
var _arguments

# @var  string|null
var _description


# @param  string           name
# @param  Callback         target
# @param  Argument[]  arguments
# @param  string|null      description
func _init(name, target, arguments, description = null):
  self._name = name
  self._target = target
  self._arguments = arguments
  self._description = description


# @param  Array  inArgs
func execute(inArgs):  # Variant
  var args = []
  var argAssig

  var i = 0
  while i < self._arguments.size() and i < inArgs.size():
    argAssig = self._arguments[i].setValue(inArgs[i])

    if argAssig == FAILED:
      Console.Log.warn(\
        'Expected ' + self._arguments[i].getType().describe() + \
        ' ' + str(i + 1) + 'as argument.')
      return
    elif argAssig == Argument.CANCELED:
      return OK

    args.append(self._arguments[i].getValue())
    i += 1

  # Execute command
  return self._target.call(args)


func describe():  # void
  Console.write(\
    '[color=#ffff66][url=' + self._name + ']' + self._name + '[/url][/color]')

  if self._arguments.size() > 0:
    for arg in self._arguments:
      Console.write(' [color=#88ffff]' + arg.describe() + '[/color]')

  if _description:
    Console.write(' - ' + _description)

  Console.writeLine()


# TODO: Deprecated, remove
# func requireArgs():  # int
#   return self._arguments.size()


# TODO: Deprecated, remove
# func requireStrings():  # bool
#   for arg in self._arguments:
#     if arg._type._name == 'Any' or arg._type._type == TYPE_STRING:
#       return true

#   return false


# @param  string      name
# @param  Dictionary  params
static func build(name, params):  # Command
  # Check target
  if !params.has('target') or !params.target:
    Console.Log.error(\
      'QC/Console/Command/Command: build: Failed to register [b]`' + \
      name + '`[/b] command. Missing [b]`target`[/b] parametr.')
    return

  # Create target if old style used
  if typeof(params.target) != TYPE_OBJECT or \
      !(params.target is Console.Callback):

    var target = params.target
    if typeof(params.target) == TYPE_ARRAY:
      target = params.target[0]

    var targetName = name

    if typeof(params.target) == TYPE_ARRAY and \
        params.target.size() > 1 and \
        typeof(params.target[1]) == TYPE_STRING:
      targetName = params.target[1]
    elif params.has('name'):
      targetName = params.name

    if Console.Callback.canCreate(target, targetName):
      params.target = Console.Callback.new(target, targetName)
    else:
      params.target = null

  if params.target:
    if not params.target is Console.Callback:
      Console.Log.error(\
        'QC/Console/Command/Command: build: Failed to register [b]`' + \
        name + '`[/b] command. Failed to create callback to target')
      return
  else:
    Console.Log.error(\
      'QC/Console/Command/Command: build: Failed to register [b]`' + \
      name + '`[/b] command. Failed to create callback to target')
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
      'QC/Console/Command/Command: build: Failed to register [b]`' + \
      name + '`[/b] command. Wrong [b]`arguments`[/b] parametr.')
    return

  if !params.has('description'):
    params.description = null

  return new(name, params.target, params.args, params.description)
