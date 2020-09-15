
extends LineEdit

# @var  RegExLib
var RegExLib = preload('../addons/quentincaffeino-regexlib/src/RegExLib.gd').new() setget _setProtected


# @const  String
const COMMANDS_SEPARATOR = ';'

# @const  String
const RECOMMANDS_SEPARATOR = '(?<!\\\\)' + COMMANDS_SEPARATOR

# @const  String
const COMMAND_PARTS_SEPARATOR = ' '

# @const  PoolStringArray
const QUOTES = [ '"', "'" ]

# @const  PoolStringArray
const SCREENERS = [ '\\/' ]

# @var  String|null
var _tmpUsrEnteredCmd

# @var  String
var _currCmd


func _ready():
	# Console keyboard control
	self.set_process_input(true)

	self.connect('text_entered', self, 'execute')

func _gui_input(event):
	if Console.consumeInput and self.has_focus():
		accept_event()

# @param  Event  e
func _input(e):
	# Show next line in history
	if Input.is_action_just_pressed(Console.action_history_up):
		self._currCmd = Console.History.current()
		Console.History.previous()

		if self._tmpUsrEnteredCmd == null:
			self._tmpUsrEnteredCmd = self.text

	# Show previous line in history
	if Input.is_action_just_pressed(Console.action_history_down):
		self._currCmd = Console.History.next()

		if !self._currCmd and self._tmpUsrEnteredCmd != null:
			self._currCmd = self._tmpUsrEnteredCmd
			self._tmpUsrEnteredCmd = null

	# Autocomplete on TAB
	if e is InputEventKey and e.pressed and e.scancode == KEY_TAB:
		var commands = Console.get_command_service().find(self.text)
		if commands.length == 1:
			self.setText(commands.getByIndex(0).getName())
		else:
			for command in commands.getValueIterator():
				var name = command.getName()
				Console.writeLine('[color=#ffff66][url=%s]%s[/url][/color]' % [ name, name ])

	# Finish
	if self._currCmd != null:
		self.setText(self._currCmd.getText() if self._currCmd and typeof(self._currCmd) == TYPE_OBJECT else self._currCmd)
		self.accept_event()
		self._currCmd = null


# @param    String  text
# @param    bool    moveCaretToEnd
# @returns  void
func setText(text, moveCaretToEnd = true):
	self.text = text
	self.grab_focus()

	if moveCaretToEnd:
		self.caret_position = text.length()


# @param    String  input
# @returns  void
func execute(input):
	Console.writeLine('[color=#999999]$[/color] ' + input)

	# @var  PoolStringArray
	var rawCommands = RegExLib.split(RECOMMANDS_SEPARATOR, input)

	# @var  Dictionary[]
	var parsedCommands = self.parseCommands(rawCommands)

	for parsedCommand in parsedCommands:
		# @var  Command/Command|null
		var command = Console.getCommand(parsedCommand.name)

		if command:
			Console.Log.debug('Executing `' + parsedCommand.command + '`.')
			command.execute(parsedCommand.arguments)
		else:
			Console.writeLine('Command `' + parsedCommand.name + '` not found.')

	Console.History.push(input)
	self.clear()


# @param    PoolStringArray  rawCommands
# @returns  Array
func parseCommands(rawCommands):
	var resultCommands = []

	for rawCommand in rawCommands:
		if rawCommand:
			resultCommands.append(self.parseCommand(rawCommand))

	return resultCommands


# @param    String  rawCommand
# @returns  Dictionary
func parseCommand(rawCommand):
	var name = null
	var arguments = PoolStringArray([])

	var beginning = 0  # int
	var openQuote  # String|null
	var isInsideQuotes = false  # boolean
	var subString  # String|null
	for i in rawCommand.length():
		# Quote
		if rawCommand[i] in QUOTES and i > 0 and not rawCommand[i - 1] in SCREENERS:
			if isInsideQuotes and rawCommand[i] == openQuote:
				openQuote = null
				isInsideQuotes = false
				subString = rawCommand.substr(beginning, i - beginning)
				beginning = i + 1
			elif !isInsideQuotes:
				openQuote = rawCommand[i]
				isInsideQuotes = true
				beginning += 1

		# Separate arguments
		elif rawCommand[i] == COMMAND_PARTS_SEPARATOR and !isInsideQuotes or i == rawCommand.length() - 1:
			if i == rawCommand.length() - 1:
				subString = rawCommand.substr(beginning, i - beginning + 1)
			else:
				subString = rawCommand.substr(beginning, i - beginning)
			beginning = i + 1

		# Save separated argument
		if subString != null and typeof(subString) == TYPE_STRING and !subString.empty():
			if !name:
				name = subString
			else:
				arguments.append(subString)
			subString = null

	return {
		'command': rawCommand,
		'name': name,
		'arguments': arguments
	}


# @returns  void
func _setProtected(value):
	Console.Log.warn('QC/Console/ConsoleLine: setProtected: Attempted to set a protected variable, ignoring.')
