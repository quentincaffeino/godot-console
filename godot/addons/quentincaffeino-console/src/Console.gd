
extends CanvasLayer

const BaseCommands = preload('Misc/BaseCommands.gd')
const CommandService = preload('Command/CommandService.gd')

### Custom console types
const IntRangeType = preload('Type/IntRangeType.gd')
const FloatRangeType = preload('Type/FloatRangeType.gd')
const FilterType = preload('Type/FilterType.gd')


# @var  History
var History = preload('Misc/History.gd').new(10) setget _setProtected

# @var  Logger
var Log = preload('Misc/Logger.gd').new() setget _setProtected

# @var  Command/CommandService
var _command_service

# Used to clear text from bb tags
# @var  RegEx
var _eraseTrash

# @var  bool
var isConsoleShown = true setget _setProtected

# @var bool
var consumeInput = true

# @var  String
export(String) var action_console_toggle = 'console_toggle'

# @var  String
export(String) var action_history_up = 'ui_up'

# @var  String
export(String) var action_history_down = 'ui_down'


### Console nodes
onready var _consoleBox = $ConsoleBox
onready var Text = $ConsoleBox/Container/ConsoleText setget _setProtected
onready var Line = $ConsoleBox/Container/ConsoleLine setget _setProtected
onready var _animationPlayer = $ConsoleBox/AnimationPlayer


func _init():
	self._command_service = CommandService.new()
	# Used to clear text from bb tags before printing to engine output
	self._eraseTrash = RegEx.new()
	self._eraseTrash.compile('\\[[\\/]?[a-z0-9\\=\\#\\ \\_\\-\\,\\.\\;]+\\]')


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


# @returns  Command/CommandService
func get_command_service():
	return self._command_service


# @param    String  name
# @returns  Command/Command|null
func getCommand(name):
	return self._command_service.get(name)

# @param    String  name
# @returns  Command/CommandCollection
func findCommands(name):
	return self._command_service.find(name)

# @param    String       name
# @param    Reference    target
# @param    String|null  target_name
# @returns  Command/CommandBuilder
func addCommand(name, target, target_name = null):
	return self._command_service.create(name, target, target_name)

# @param    String  name
# @returns  int
func removeCommand(name):
	return self._command_service.remove(name)


# @param    String  message
# @returns  void
func write(message):
	message = str(message)
	if self.Text:
		self.Text.set_bbcode(self.Text.get_bbcode() + message)
	print(self._eraseTrash.sub(message, '', true))


# @param    String  message
# @returns  void
func writeLine(message = ''):
	message = str(message)
	if self.Text:
		self.Text.set_bbcode(self.Text.get_bbcode() + message + '\n')
	print(self._eraseTrash.sub(message, '', true))


# @returns  void
func clear():
	if self.Text:
		self.Text.set_bbcode('')


# @returns  void
func toggleConsole():
	# Open the console
	if !isConsoleShown:
		self._consoleBox.show()
		self.Line.clear()
		self.Line.grab_focus()
		self._animationPlayer.play_backwards('fade')
	else:
		self._animationPlayer.play('fade')

	isConsoleShown = !isConsoleShown


# @returns  void
func _toggleAnimationFinished(animation):
	if !isConsoleShown:
		self._consoleBox.hide()


# @returns  void
func _setProtected(value):
	Log.warn('QC/Console: setProtected: Attempted to set a protected variable, ignoring.')
