
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
    elif argAssig == Argument.ARGASSIG.CANCELED:
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
