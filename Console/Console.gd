
extends 'IConsole.gd'


### Console nodes
onready var _consoleBox = $ConsoleBox
onready var _consoleText = $ConsoleBox/Container/ConsoleText
onready var _consoleLine = $ConsoleBox/Container/LineEdit
onready var _animationPlayer = $ConsoleBox/AnimationPlayer


func _init():
	# Used to clear text from bb tags
	_eraseTrash = RegEx.new()
	_eraseTrash.compile('\\[[\\/]?[a-z\\=\\#0-9\\ \\_\\-]+\\]')


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

	# By default we show help
	var v = Engine.get_version_info()
	writeLine(\
		ProjectSettings.get_setting("application/config/name") + \
		" (Godot " + str(v.major) + '.' + str(v.minor) + '.' + str(v.patch) + ' ' + v.status+")\n" + \
		"Type [color=#ffff66][url=help]help[/url][/color] to get more information about usage")

	# Init base commands
	BaseCommands.new()


# @param  Event  e
func _input(e):
	if Input.is_action_just_pressed("console_toggle"):
		toggleConsole()

	# Show prev line in history
	if Input.is_action_just_pressed("console_up"):
		_currHistCmd = _History.prev()

		if _currCmdHandler == null:
			_currCmdHandler = _consoleLine.text

	# Show next line in history
	if Input.is_action_just_pressed("console_down"):
		_currHistCmd = _History.next()

		if !_currHistCmd and _currCmdHandler != null:
			_currHistCmd = _currCmdHandler
			_currCmdHandler = null

	# Autocomplete on TAB
	if _consoleLine.text and _consoleLine.has_focus() and Input.is_key_pressed(KEY_TAB):
		if !_Commands.Autocomplete._filtered.has(_consoleLine.text):
			_currCmdHandler = _consoleLine.text
			_Commands.Autocomplete.reset()

		_Commands.Autocomplete.filter(_currCmdHandler)
		_currHistCmd = _Commands.Autocomplete.next()

	# Finish
	if _currHistCmd != null:
		_consoleLine.text = _currHistCmd
		_consoleLine.set_cursor_position(_currHistCmd.length()+1)
		_currHistCmd = null


# @param  string  command
func _handleEnteredCommand(command):  # void
	# Some preparations
	_History.reset()
	_Commands.Autocomplete.reset()
	command = _eraseTrash.sub(command, '', true)

	# Get command name
	var cmdName = command.split(' ', false)
	if typeof(cmdName) != TYPE_STRING_ARRAY:
		Log.warn('Could not get command name')
		return
	cmdName = cmdName[0]

	var Command = _Commands.get(cmdName)

	if !Command:
		Log.warn('No such command')
		return

	# Get args
	var args = []
	var cmdArgs = command.substr(cmdName.length() + 1, command.length())
	if Command.requireArgs():

		if Command._target._type == Console.Callback.VARIABLE or Command._arguments.size() == 1:
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
	_History.push(Command._alias + ' ' + cmdArgs)
	writeLine('[color=#999999]$[/color] ' + Command._alias + ' ' + cmdArgs)
	Command.run(args)
	_consoleLine.clear()


# @param  string  url
func _handleUrlClick(url):  # void
	_consoleLine.text = url
	_consoleLine.grab_focus()
	_consoleLine.set_cursor_position(url.length()+1)


# @param  string  alias
# @param  Dictionary  params
func register(alias, params):  # int
	return _Commands.register(alias, params)


# @param  string  message
func write(message):  # void
	message = str(message)
	print(_eraseTrash.sub(message, '', true))
	_consoleText.set_bbcode(_consoleText.get_bbcode() + message)


# @param  string  message
func writeLine(message = ''):  # void
	message = str(message)
	print(_eraseTrash.sub(message, '', true))
	_consoleText.set_bbcode(_consoleText.get_bbcode() + message + '\n')


func toggleConsole():  # void
	# Open the console
	if !_isConsoleShown:
		_consoleBox.show()
		_consoleLine.clear()
		_consoleLine.grab_focus()
		_animationPlayer.play_backwards('fade')
	else:
		_animationPlayer.play('fade')

	_isConsoleShown = !_isConsoleShown


func _toggleAnimationFinished(animation):  # void
	if !_isConsoleShown:
		_consoleBox.hide()
