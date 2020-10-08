
extends CanvasLayer

const BaseCommands = preload('Misc/BaseCommands.gd')
const DefaultActions = preload('./Misc/DefaultActions.gd')
const DefaultActionServiceFactory = preload('./Misc/DefaultActionServiceFactory.gd')
const CommandService = preload('Command/CommandService.gd')

### Custom console types
const IntRangeType = preload('Type/IntRangeType.gd')
const FloatRangeType = preload('Type/FloatRangeType.gd')
const FilterType = preload('Type/FilterType.gd')


# @var  History
var History = preload('Misc/History.gd').new(10) setget _set_protected

# @var  Logger
var Log = preload('Misc/Logger.gd').new() setget _set_protected

# @var  Command/CommandService
var _command_service

# @var  ActionService
var _action_service

# Used to clear text from bb tags
# @var  RegEx
var _erase_bb_tags_regex

# @var  bool
var is_console_shown = true setget _set_protected

# @var bool
var consume_input = true


### Console nodes
onready var _consoleBox = $ConsoleBox
onready var Text = $ConsoleBox/Container/ConsoleText setget _set_protected
onready var Line = $ConsoleBox/Container/ConsoleLine setget _set_protected
onready var _animationPlayer = $ConsoleBox/AnimationPlayer


func _init():
	self._command_service = CommandService.new(self)
	self._action_service = DefaultActionServiceFactory.create()
	# Used to clear text from bb tags before printing to engine output
	self._erase_bb_tags_regex = RegEx.new()
	self._erase_bb_tags_regex.compile('\\[[\\/]?[a-z0-9\\=\\#\\ \\_\\-\\,\\.\\;]+\\]')


func _ready():
	# Allow selecting console text
	self.Text.set_selection_enabled(true)
	# Follow console output (for scrolling)
	self.Text.set_scroll_follow(true)
	# React to clicks on console urls
	self.Text.connect('meta_clicked', self.Line, 'set_text')

	# Hide console by default
	self._consoleBox.hide()
	self._animationPlayer.connect("animation_finished", self, "_toggle_animation_finished")
	self.toggle_console()

	# Console keyboard control
	set_process_input(true)

	# Show some info
	var v = Engine.get_version_info()
	self.write_line(\
		ProjectSettings.get_setting("application/config/name") + \
		" (Godot " + str(v.major) + '.' + str(v.minor) + '.' + str(v.patch) + ' ' + v.status+")\n" + \
		"Type [color=#ffff66][url=help]help[/url][/color] to get more information about usage")

	# Init base commands
	self.BaseCommands.new(self)


# @param  InputEvent  e
func _input(e):
	if Input.is_action_just_pressed(self.get_action_service().get_real_action_name(DefaultActions.action_console_toggle)):
		self.toggle_console()


# @returns  Command/CommandService
func get_command_service():
	return self._command_service


# @returns  Misc/ActionService
func get_action_service():
	return self._action_service


# @deprecated
# @param    String  name
# @returns  Command/Command|null
func getCommand(name):
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `get_command`. Please refer to documentation for more info.")
	return self.get_command(name)

# @param    String  name
# @returns  Command/Command|null
func get_command(name):
	return self._command_service.get(name)

# @deprecated
# @param    String  name
# @returns  Command/CommandCollection
func findCommands(name):
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `find_commands`. Please refer to documentation for more info.")
	return self.find_commands(name)

# @param    String  name
# @returns  Command/CommandCollection
func find_commands(name):
	return self._command_service.find(name)

# @deprecated
# @param    String       name
# @param    Reference    target
# @param    String|null  target_name
# @returns  Command/CommandBuilder
func addCommand(name, target, target_name = null):
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `add_command`. Please refer to documentation for more info.")
	return self.add_command(name, target, target_name)

# Example usage:
# ```gdscript
# Console.add_command('sayHello', self, 'print_hello')\
# 	.set_description('Prints "Hello %name%!"')\
# 	.add_argument('name', TYPE_STRING)\
# 	.register()
# ```
# @param    String       name
# @param    Reference    target
# @param    String|null  target_name
# @returns  Command/CommandBuilder
func add_command(name, target, target_name = null):
	return self._command_service.create(name, target, target_name)

# @deprecated
# @param    String  name
# @returns  int
func removeCommand(name):
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `remove_command`. Please refer to documentation for more info.")
	return self.remove_command(name)

# @param    String  name
# @returns  int
func remove_command(name):
	return self._command_service.remove(name)


# @param    String  message
# @returns  void
func write(message):
	message = str(message)
	if self.Text:
		self.Text.set_bbcode(self.Text.get_bbcode() + message)
	print(self._erase_bb_tags_regex.sub(message, '', true))


# @deprecated
# @param    String  message
# @returns  void
func writeLine(message = ''):
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `write_line`. Please refer to documentation for more info.")
	self.write_line(message)


# @param    String  message
# @returns  void
func write_line(message = ''):
	message = str(message)
	if self.Text:
		self.Text.set_bbcode(self.Text.get_bbcode() + message + '\n')
	print(self._erase_bb_tags_regex.sub(message, '', true))


# @returns  void
func clear():
	if self.Text:
		self.Text.set_bbcode('')


# @returns  Console
func toggleConsole():
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `toggle_console`. Please refer to documentation for more info.")
	return self.toggle_console()

# @returns  Console
func toggle_console():
	# Open the console
	if !self.is_console_shown:
		self._consoleBox.show()
		self.Line.clear()
		self.Line.grab_focus()
		self._animationPlayer.play_backwards('fade')
	else:
		self._animationPlayer.play('fade')

	is_console_shown = !self.is_console_shown

	return self


# @returns  void
func _toggle_animation_finished(animation):
	if !self.is_console_shown:
		self._consoleBox.hide()


# @returns  void
func _set_protected(value):
	Log.warn('QC/Console: set_protected: Attempted to set a protected variable, ignoring.')
