
extends CanvasLayer
const BaseCommands = preload('BaseCommands.gd')
const Callback = preload('Callback.gd')

### Custom console types
const IntRange = preload('Commands/Types/IntRange.gd')
const FloatRange = preload('Commands/Types/FloatRange.gd')
const Filter = preload('Commands/Types/Filter.gd')


enum CMDTYPE {
	VARIABLE,
	METHOD
}


# @var  Commands
var _Commands = preload('Commands/Commands.gd').new() setget _setProtected

# @var  History
var _History = preload('History.gd').new() setget _setProtected

# @var  Log
var Log = preload('Log.gd').new() setget _setProtected

# @var  RegExLib
var RegExLib = preload('RegExLib.gd').new() setget _setProtected

# Used to clear text from bb tags
# @var  RegEx
var _eraseTrash

# @var  bool
var _isConsoleShown = true

# @var  string|null
var _currCmdHandler = null

# @var  string|null
var _currHistCmd = null


# @param  string  command
func _handleEnteredCommand(command):  # void
	pass


# @param  string  url
func _handleUrlClick(url):  # void
	pass


# @param  string  alias
# @param  Dictionary  params
func register(alias, params):  # int
	pass


# @param  string  message
func write(message):  # void
	pass


# @param  string  message
func writeLine(message = ''):  # void
	pass


func toggleConsole():  # void
	pass


func _toggleAnimationFinished(animation):  # void
	pass


func _setProtected(value):  # void
	pass
