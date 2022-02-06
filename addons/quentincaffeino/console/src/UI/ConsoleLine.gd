
extends LineEdit

const DefaultActions = preload('../DefaultActions.gd')
const RegExLib = preload('res://addons/quentincaffeino/regexlib/src/RegExLib.gd')


# @param  int  scancode
signal keypress(scancode)


# @var  String|null
var _tmp_user_entered_command

# @var  String
var _current_command


func _ready():
	# Console keyboard control
	self.set_process_input(true)


# @param  InputEvent
func _gui_input(event):
	if Console.consume_input and self.has_focus():
		accept_event()


# @var  SceneTreeTimer
var _autocomplete_triggered_timer

# @param  InputEvent  e
func _input(e):
	# Don't process input if console is not visible
	if !is_visible_in_tree():
		return

	if e is InputEventKey and not e.pressed:
		self.emit_signal("keypress", e.unicode)

	# Show next line in history
	if Input.is_action_just_pressed(DefaultActions.CONSOLE_HISTORY_UP):
		self._current_command = Console.History.current()
		Console.History.previous()

		if self._tmp_user_entered_command == null:
			self._tmp_user_entered_command = self.text

	# Show previous line in history
	if Input.is_action_just_pressed(DefaultActions.CONSOLE_HISTORY_DOWN):
		self._current_command = Console.History.next()

		if !self._current_command and self._tmp_user_entered_command != null:
			self._current_command = self._tmp_user_entered_command
			self._tmp_user_entered_command = null

	# Autocomplete on TAB
	if Input.is_action_just_pressed(DefaultActions.CONSOLE_AUTOCOMPLETE):
		if self._autocomplete_triggered_timer and self._autocomplete_triggered_timer.get_time_left() > 0:
			self._autocomplete_triggered_timer = null
			var commands = Console.get_command_service().find(self.text)
			if commands.length == 1:
				self.set_text(commands.get_by_index(0).get_name())
			else:
				for command in commands.get_value_iterator():
					var name = command.get_name()
					Console.write_line('[color=#ffff66][url=%s]%s[/url][/color]' % [ name, name ])
		else:
			self._autocomplete_triggered_timer = get_tree().create_timer(1.0, true)
			var autocompleted_command = Console.get_command_service().autocomplete(self.text)
			self.set_text(autocompleted_command)

	# Finish
	if self._current_command != null:
		self.set_text(self._current_command.getText() if self._current_command and typeof(self._current_command) == TYPE_OBJECT else self._current_command)
		self.accept_event()
		self._current_command = null


# @param    String  text
# @param    bool    move_caret_to_end
# @returns  void
func set_text(text, move_caret_to_end = true):
	self.text = text
	self.grab_focus()

	if move_caret_to_end:
		self.caret_position = text.length()


# @returns  void
func _set_readonly(value):
	Console.Log.warn('QC/Console/ConsoleLine: _set_readonly: Attempted to set a protected variable, ignoring.')
