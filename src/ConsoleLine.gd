
extends LineEdit


# @const  string
const COMMANDS_SEPARATOR = ';'

# @const  string
const RECOMMANDS_SEPARATOR = '(?<!\\\\)' + COMMANDS_SEPARATOR

# @const  string
const COMMAND_PARTS_SEPARATOR = ' '

# @const  string[]
const QUOTES = [ '"', "'" ]

# @const  string[]
const SCREENERS = [ '\\/' ]

# @var  string|null
var _tmpUsrEnteredCmd

# @var  string
var _currCmd


func _ready():
	# Console keyboard control
	self.set_process_input(true)

	self.connect('text_entered', self, 'execute')


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
	# TODO: Maybe later

	# Finish
	if self._currCmd != null:
		self.setText(self._currCmd.getText() if self._currCmd and typeof(self._currCmd) == TYPE_OBJECT else self._currCmd)
		self.accept_event()
		self._currCmd = null


# @param  string  text
# @param  bool    moveCaretToEnd
func setText(text, moveCaretToEnd = true):  # void
	self.text = text
	self.grab_focus()

	if moveCaretToEnd:
		self.caret_position = text.length()


# @param  string  input
func execute(input):
	Console.writeLine('[color=#999999]$[/color] ' + input)

	# @var  string[]
	var rawCommands = Console.RegExLib.split(RECOMMANDS_SEPARATOR, input)

	# @var  Dictionary[]
	var parsedCommands = self.parseCommands(rawCommands)

	# @var  Command/Command|null
	var command = null

	for parsedCommand in parsedCommands:
		command = Console.getCommand(parsedCommand.name)

		if command:
			Console.Log.debug('Executing `' + parsedCommand.command + '`.')
			command.execute(parsedCommand.arguments)
			Console.History.push(input)
			self.clear()


# @param  string[]  rawCommands
func parseCommands(rawCommands):  # Dictionary[]
	var resultCommands = []

	for rawCommand in rawCommands:
		if rawCommand:
			resultCommands.append(self.parseCommand(rawCommand))

	return resultCommands


# @param  string  rawCommand
func parseCommand(rawCommand):  # Dictionary
	var name = null
	var arguments = PoolStringArray([])

	var beginning = 0  # int
	var openQuote  # string|null
	var isInsideQuotes = false  # boolean
	var subString  # string|null
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
