
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


# @param  string       name
# @param  Callback     target
# @param  Argument[]   arguments
# @param  string|null  description
func _init(name, target, arguments = [], description = null):
  self._name = name
  self._target = target
  self._arguments = arguments
  self._description = description


func getName():  # string
  return self._name


func getTarget():  # Callback
  return self._target


func getArguments():  # Argument[]
  return self._arguments


func getDescription():  # string|null
  return self._description


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


# @var  string  name
# @var  Array   parameters
static func build(name, parameters):  # Command|null
  # Check target
  if !parameters.has('target') or !parameters.target:
    Console.Log.error(\
      'QC/Console/Command/Command: build: Failed to create [b]`' + \
      name + '`[/b] command. Missing [b]`target`[/b] parametr.')
    return

  # Create target if old style used
  if typeof(parameters.target) != TYPE_OBJECT or \
      !(parameters.target is Console.Callback):

    var target = parameters.target
    if typeof(parameters.target) == TYPE_ARRAY:
      target = parameters.target[0]

    var targetName = name

    if typeof(parameters.target) == TYPE_ARRAY and \
        parameters.target.size() > 1 and \
        typeof(parameters.target[1]) == TYPE_STRING:
      targetName = parameters.target[1]
    elif parameters.has('name'):
      targetName = parameters.name

    if Console.Callback.canCreate(target, targetName):
      parameters.target = Console.Callback.new(target, targetName)
    else:
      parameters.target = null

  if parameters.target:
    if not parameters.target is Console.Callback:
      Console.Log.error(\
        'QC/Console/Command/Command: build: Failed to create [b]`' + \
        name + '`[/b] command. Failed to create callback to target')
      return
  else:
    Console.Log.error(\
      'QC/Console/Command/Command: build: Failed to create [b]`' + \
      name + '`[/b] command. Failed to create callback to target')
    return

  # Set arguments
  if parameters.target._type == Console.Callback.VARIABLE and parameters.has('args'):
    # Ignore all arguments except first cause variable takes only one arg
    parameters.args = [parameters.args[0]]

  if parameters.has('arg'):
    parameters.args = Argument.buildAll([ parameters.arg ])
    parameters.erase('arg')
  elif parameters.has('args'):
    parameters.args = Argument.buildAll(parameters.args)
  else:
    parameters.args = []

  if typeof(parameters.args) == TYPE_INT:
    Console.Log.error(\
      'QC/Console/Command/Command: build: Failed to register [b]`' + \
      name + '`[/b] command. Wrong [b]`arguments`[/b] parametr.')
    return

  if !parameters.has('description'):
    parameters.description = null

  return new(name, parameters.target, parameters.args, parameters.description)
