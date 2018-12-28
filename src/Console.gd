
extends CanvasLayer

const TypesBuilder = preload('Types/TypesBuilder.gd')
const BaseType = preload('Types/BaseType.gd')
const Argument = preload('Command/Argument.gd')
const Command = preload('Command/Command.gd')

const BaseCommands = preload('BaseCommands.gd')
const Callback = preload('../vendor/quentincaffeino/callback/src/Callback.gd')
const Group = preload('Command/Group.gd')

### Custom console types
const IntRange = preload('Types/IntRange.gd')
const FloatRange = preload('Types/FloatRange.gd')
const Filter = preload('Types/Filter.gd')


# @var  History
var History = preload('History.gd').new() setget _setProtected

# @var  Log
var Log = preload('Log.gd').new() setget _setProtected

# @var  RegExLib
var RegExLib = preload('RegExLib.gd').new() setget _setProtected

# @var  Command/Group
var _rootGroup

# Used to clear text from bb tags
# @var  RegEx
var _eraseTrash

# @var  bool
var isConsoleShown = true setget _setProtected

# @var  bool
var submitAutocomplete = true

# @var  string
export(String) var action_console_toggle = 'console_toggle'

# @var  string
export(String) var action_history_up = 'ui_up'

# @var  string
export(String) var action_history_down = 'ui_down'


### Console nodes
onready var _consoleBox = $ConsoleBox
onready var Text = $ConsoleBox/Container/ConsoleText setget _setProtected
onready var Line = $ConsoleBox/Container/ConsoleLine setget _setProtected
onready var _animationPlayer = $ConsoleBox/AnimationPlayer


func _init():
  self._rootGroup = Group.new('root')
  # Used to clear text from bb tags
  self._eraseTrash = RegExLib.getPatternFor('console.eraseTrash')


func _ready():
  # Allow selecting console text
  self.Text.set_selection_enabled(true)
  # Follow console output (for scrolling)
  self.Text.set_scroll_follow(true)
  # React to clicks on console urls
  self.Text.connect('meta_clicked', self.Line, 'setText')

  # Hide console by default
  self._consoleBox.hide()
  self._animationPlayer.connect("animation_finished", self, "_toggleAnimationFinished")
  self.toggleConsole()

  # Console keyboard control
  set_process_input(true)

  # Show some info
  var v = Engine.get_version_info()
  writeLine(\
    ProjectSettings.get_setting("application/config/name") + \
    " (Godot " + str(v.major) + '.' + str(v.minor) + '.' + str(v.patch) + ' ' + v.status+")\n" + \
    "Type [color=#ffff66][url=help]help[/url][/color] to get more information about usage")

  # Init base commands
  self.BaseCommands.new()


# @param  Event  e
func _input(e):
  if Input.is_action_just_pressed(self.action_console_toggle):
    self.toggleConsole()


# @param  string  name
func getCommand(name):  # Command/CommandHandler|null
  return self._rootGroup.getCommand(name)


# @param  string  name
# @param  Variant[]   parparametersams
func register(name, parameters = []):  # bool
  return self._rootGroup.registerCommand(name, parameters)


# @param  string  name
func unregister(name):  # int
  return self._rootGroup.unregisterCommand(name)


# @param  string  message
func write(message):  # void
  message = str(message)
  self.Text.set_bbcode(self.Text.get_bbcode() + message)
  print(self._eraseTrash.sub(message, '', true))
  

# @param  string  message
func writeLine(message = ''):  # void
  message = str(message)
  self.Text.set_bbcode(self.Text.get_bbcode() + message + '\n')
  print(self._eraseTrash.sub(message, '', true))


func clear():  # void
  self.Text.set_bbcode('')


func toggleConsole():  # void
  # Open the console
  if !isConsoleShown:
    self._consoleBox.show()
    self.Line.clear()
    self.Line.grab_focus()
    self._animationPlayer.play_backwards('fade')
  else:
    self._animationPlayer.play('fade')

  isConsoleShown = !isConsoleShown


func _toggleAnimationFinished(animation):  # void
  if !isConsoleShown:
    self._consoleBox.hide()


func _setProtected(value):  # void
  Log.warn('QC/Console: setProtected: Attempted to set a protected variable, ignoring.')


# @param  string|null   name
# @param  int|BaseType  type
static func build_argument(name, type = 0):  # Argument|int
  # Define arument type
  if !(typeof(type) == TYPE_OBJECT and type is BaseType):
    type = TypesBuilder.build(type if typeof(type) == TYPE_INT else 0)

  if not type is BaseType:
    Console.Log.error(\
      'QC/Console/Command/Argument: build: Argument of type [b]' + str(type) + '[/b] isn\'t supported.')
    return FAILED

  return Argument.new(name, type)


# @param  Variant[]  args
static func build_arguments(args):  # Argument[]|int
  # @var  Argument[]|int  builtArgs
  var builtArgs = []

  # @var  Argument|int|null  tempArg
  var tempArg
  for arg in args:
    tempArg = null

    match typeof(arg):
      # [ 'argName', BaseType|ARG_TYPE ]
      TYPE_ARRAY:
        tempArg = build_argument(arg[0], arg[1] if arg.size() > 1 else 0)

      # 'argName'
      TYPE_STRING:
        tempArg = build_argument(arg)

      # BaseType|ARG_TYPE
      TYPE_OBJECT, TYPE_INT:
        tempArg = build_argument(null, arg)

    if typeof(tempArg) == TYPE_INT:
      return FAILED

    builtArgs.append(tempArg)

  return builtArgs

# @var  string     name
# @var  Variant[]  parameters
static func build_command(name, parameters):  # Command|null
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
  if parameters.target._type == Console.Callback.TYPE.VARIABLE and parameters.has('args'):
    # Ignore all arguments except first cause variable takes only one arg
    parameters.args = [parameters.args[0]]

  if parameters.has('arg'):
    parameters.args = Console.build_arguments([ parameters.arg ])
    parameters.erase('arg')
  elif parameters.has('args'):
    parameters.args = Console.build_arguments(parameters.args)
  else:
    parameters.args = []

  if typeof(parameters.args) == TYPE_INT:
    Console.Log.error(\
      'QC/Console/Command/Command: build: Failed to register [b]`' + \
      name + '`[/b] command. Wrong [b]`arguments`[/b] parametr.')
    return

  if !parameters.has('description'):
    parameters.description = null

  return Command.new(name, parameters.target, parameters.args, parameters.description)
