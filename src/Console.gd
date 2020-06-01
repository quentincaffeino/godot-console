
extends CanvasLayer

const BaseCommands = preload('Misc/BaseCommands.gd')
# @deprecated
const Callback= preload('../addons/quentincaffeino-callback/src/Callback.gd')
const CallbackBuilder= preload('../addons/quentincaffeino-callback/src/CallbackBuilder.gd')
const CommandGroup = preload('Command/CommandGroup.gd')
const CommandBuilder = preload('Command/CommandBuilder.gd')

### Custom console types
const IntRange = preload('Type/IntRange.gd')
const FloatRange = preload('Type/FloatRange.gd')
const Filter = preload('Type/Filter.gd')


# @var  History
var History = preload('Misc/History.gd').new(10) setget _setProtected

# @var  Logger
var Log = preload('Misc/Logger.gd').new() setget _setProtected

# @var  RegExLib
var RegExLib = preload('../addons/quentincaffeino-regexlib/src/RegExLib.gd').new() setget _setProtected

# @var  Command/CommandGroup
var _rootGroup

# Used to clear text from bb tags
# @var  RegEx
var _eraseTrash

# @var  bool
var isConsoleShown = true setget _setProtected

# @var  bool
var submitAutocomplete = true

# @var bool
var consumeInput = true

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
	self._rootGroup = CommandGroup.new('root')
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
func getCommand(name):  # Command/Command|null
	return self._rootGroup.getCommand(name)


# @param  string     name
# @param  Variant[]  parameters
func register(name, parameters = []):  # bool
	Log.warn('QC/Console: register: register() method is deprecated and will be removed. Please refer to the documentation to update your code to use addCommand.')
	return self._rootGroup.registerCommand(name, parameters)


# @param  string  name
func unregister(name):  # int
	Log.warn('QC/Console: unregister: unregister() method is deprecated and will be removed. Please use removeCommand.')
	return self._rootGroup.unregisterCommand(name)


# @param  string       name
# @param  Reference    target
# @param  string|null  targetName
func addCommand(name, target, targetName = null):  # CommandBuilder
	return CommandBuilder.new(_rootGroup, name, target, targetName)

# @param  string  name
func removeCommand(name):  # int
	return self._rootGroup.unregisterCommand(name)


# @param  string  message
func write(message):  # void
	message = str(message)
	if self.Text:
		self.Text.set_bbcode(self.Text.get_bbcode() + message)
	print(self._eraseTrash.sub(message, '', true))


# @param  string  message
func writeLine(message = ''):  # void
	message = str(message)
	if self.Text:
		self.Text.set_bbcode(self.Text.get_bbcode() + message + '\n')
	print(self._eraseTrash.sub(message, '', true))


func clear():  # void
	if self.Text:
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
