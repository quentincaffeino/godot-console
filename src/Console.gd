
extends CanvasLayer

const BaseCommands = preload('BaseCommands.gd')
const Callback = preload('Callback.gd')

### Custom console types
const IntRange = preload('Types/IntRange.gd')
const FloatRange = preload('Types/FloatRange.gd')
const Filter = preload('Types/Filter.gd')


enum CMDTYPE \
{
  VARIABLE,
  METHOD
}


# @var  Commands
var _Commands = preload('Commands.gd').new()

# @var  History
var _History = preload('History.gd').new()

# @var  Log
var Log = preload('Log.gd').new() setget _setProtected

# @var  RegExLib
var RegExLib = preload('RegExLib.gd').new() setget _setProtected

# Used to clear text from bb tags
# @var  RegEx
var _eraseTrash

# @var  bool
var isConsoleShown = true setget _setProtected

# @var  string|null
var _currCmdHandler = null

# @var  string|null
var _currCmd = null

# @var  bool
var debugMode = false

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
onready var _consoleText = $ConsoleBox/Container/ConsoleText
onready var _consoleLine = $ConsoleBox/Container/LineEdit
onready var _animationPlayer = $ConsoleBox/AnimationPlayer


func _init():
  # Used to clear text from bb tags
  _eraseTrash = RegExLib.get('console.eraseTrash')


func _ready():
  # Allow selecting console text
  _consoleText.set_selection_enabled(true)
  # Follow console output (for scrolling)
  _consoleText.set_scroll_follow(true)
  # React to clicks on console urls
  _consoleText.connect('meta_clicked', self, '_handleUrlClick')

  # Hide console by default
  _consoleBox.hide()
  _animationPlayer.connect("animation_finished", self, "_toggleAnimationFinished")
  toggleConsole()

  # Console keyboard control
  set_process_input(true)

  _consoleLine.connect('text_entered', self, '_handleEnteredCommand')

  # Show some info
  var v = Engine.get_version_info()
  writeLine(\
    ProjectSettings.get_setting("application/config/name") + \
    " (Godot " + str(v.major) + '.' + str(v.minor) + '.' + str(v.patch) + ' ' + v.status+")\n" + \
    "Type [color=#ffff66][url=help]help[/url][/color] to get more information about usage")

  # Init base commands
  BaseCommands.new()


# @param  Event  e
func _input(e):
  if Input.is_action_just_pressed(action_console_toggle):
    toggleConsole()

  # Show prev line in history
  if Input.is_action_just_pressed(action_history_up):
    _currCmd = _History.prev()

    if _currCmdHandler == null:
      _currCmdHandler = _consoleLine.text

  # Show next line in history
  if Input.is_action_just_pressed(action_history_down):
    _currCmd = _History.next()

    if !_currCmd and _currCmdHandler != null:
      _currCmd = _currCmdHandler
      _currCmdHandler = null

  # Autocomplete on TAB
  if _consoleLine.text and _consoleLine.has_focus() and Input.is_key_pressed(KEY_TAB):
    if !_Commands.Autocomplete._filtered.has(_consoleLine.text):
      _currCmdHandler = _consoleLine.text
      _Commands.Autocomplete.reset()

    _Commands.Autocomplete.filter(_currCmdHandler)
    _currCmd = _Commands.Autocomplete.next()

  # Finish
  if _currCmd != null:
    _setConsoleLine(_currCmd)
    _currCmd = null
    _consoleLine.accept_event()


# @param  string  command
func _handleEnteredCommand(command):  # void
  if command.empty():
    return

  # Some preparations
  _History.reset()
  _Commands.Autocomplete.reset()
  command = _eraseTrash.sub(command, '', true)

  # Get command name
  var cmdName = command.split(' ', false)
  if typeof(cmdName) != TYPE_STRING_ARRAY:
    Log.warn('Could not get command name', \
      'Console: _handleEnteredCommand')
    return
  cmdName = cmdName[0]

  var Command = _Commands.get(cmdName)

  if !Command:
    Log.warn('No such command', \
      'Console: _handleEnteredCommand')
    return

  # Get args
  var args = []
  var cmdArgs = null
  if Command.requireArgs():
    cmdArgs = command.substr(cmdName.length() + 1, command.length())

    if Command._target._type == Console.Callback.TYPE.VARIABLE or Command._arguments.size() == 1:
      args.append(cmdArgs)
    elif Command.requireStrings():

      var isString = null
      var prevDelimiter = 0

      var i = 0
      while Command.requireArgs() != args.size():
        if cmdArgs[i] == '"' or cmdArgs[i] == "'":
          if !isString:
            isString = cmdArgs[i]
          elif cmdArgs[i] == isString and cmdArgs[i - 1 if i > 0 else 0] != '\\':
            isString = null

        if !isString:
          if prevDelimiter and (cmdArgs[i] == '"' or cmdArgs[i] == "'"):
            args.append(cmdArgs.substr(prevDelimiter + 1, i - 3).replace('\\' + \
              str(cmdArgs[prevDelimiter]), cmdArgs[prevDelimiter]))
            prevDelimiter = i + 1
          elif cmdArgs[i] == ' ' and cmdArgs[i + 1 if i < cmdArgs.length() - 1 else i] != ' ':
            args.append(cmdArgs.substr(prevDelimiter, i))
            prevDelimiter = i + 1

        i += 1

    else:
      args = cmdArgs.split(' ', false)

  # Execute
  var finCommand = Command._alias
  if cmdArgs:
    finCommand += ' ' + cmdArgs

  _History.push(finCommand)
  writeLine('[color=#999999]$[/color] ' + finCommand)
  Command.run(args)
  _consoleLine.clear()


# @param  string  url
func _handleUrlClick(url):  # void
  _setConsoleLine(url + ' ')


# @param  string  text
# @param  bool    moveCaretToEnd
func _setConsoleLine(text, moveCaretToEnd = true):  # void
  _consoleLine.text = text
  _consoleLine.grab_focus()

  if moveCaretToEnd:
    _consoleLine.caret_position = text.length()


# @param  string      alias
# @param  Dictionary  params
func register(alias, params):  # int
  return _Commands.register(alias, params)


# @param  string  alias
func unregister(alias):  # int
  return _Commands.unregister(alias)


# @param  string  message
func write(message):  # void
  message = str(message)
  _consoleText.set_bbcode(_consoleText.get_bbcode() + message)
  print(_eraseTrash.sub(message, '', true))
  

# @param  string  message
func writeLine(message = ''):  # void
  message = str(message)
  _consoleText.set_bbcode(_consoleText.get_bbcode() + message + '\n')
  print(_eraseTrash.sub(message, '', true))


func clear():  # void
  _consoleText.set_bbcode('')


func toggleConsole():  # void
  # Open the console
  if !isConsoleShown:
    _consoleBox.show()
    _consoleLine.clear()
    _consoleLine.grab_focus()
    _animationPlayer.play_backwards('fade')
  else:
    _animationPlayer.play('fade')

  isConsoleShown = !isConsoleShown


func _toggleAnimationFinished(animation):  # void
  if !isConsoleShown:
    _consoleBox.hide()


func _setProtected(value):  # void
  Log.warn('Trying to set a protected variable, ignoring. Provided ' + str(value), \
    'Console: _setProtected')
