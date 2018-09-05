
extends LineEdit

const CommandHandler = preload('Command/CommandHandler.gd')


# @const  string
const COMMAND_SEPARATOR = ';'

# @const  string
const ARGUMENT_SEPARATOR = ' '

# @const  Variant[]
const QUOTE = [ '"', "'" ]

# @const  string
const QUOTE_SCREENER = '\\/'

# @var  string|null
var _currCmdHandler

# @var  Command/CommandHandler
var _currCmd


func _ready():
  # Console keyboard control
  self.set_process_input(true)

  self.connect('text_entered', self, 'exec')


# @param  Event  e
func _input(e):
  # Show next line in history
  if Input.is_action_just_pressed(Console.action_history_up):
    self._currCmd = Console.History.current()
    Console.History.previous()

    if self._currCmdHandler == null:
      self._currCmdHandler = self.text

  # Show previous line in history
  if Input.is_action_just_pressed(Console.action_history_down):
    self._currCmd = Console.History.next()

    if !self._currCmd and self._currCmdHandler != null:
      self._currCmd = self._currCmdHandler
      self._currCmdHandler = null

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


# @param  string  sCommand
func exec(sCommand):
  Console.writeLine('[color=#999999]$[/color] ' + sCommand)
  var parsedCommands = self.parseCommands(sCommand)

  # @var  Command/CommandHandler|null
  var command

  for parsedCommand in parsedCommands:
    command = Console.getCommand(parsedCommand.name)

    if command:
      command\
        .setText(sCommand)\
        .setArguments(parsedCommand.arguments)\
        .execute()
      Console.History.push(command)
      Console.History.last()
      self.clear()


# @param  string  string
static func parseCommands(sCommand):  # Variant[]
  var result = [{
    'name': null,
    'arguments': []
  }]
  var currentCommand = 0

  var beginning = 0  # int
  var openQuote  # string|null
  var isInsideQuotes = false  # boolean
  var subString  # string|null
  for i in sCommand.length():
    # Quote
    if sCommand[i] in QUOTE and i > 0 and sCommand[i - 1] != QUOTE_SCREENER:
      if isInsideQuotes and sCommand[i] == openQuote:
        openQuote = null
        isInsideQuotes = false
        subString = sCommand.substr(beginning, i - beginning)
        beginning = i + 1
      elif !isInsideQuotes:
        openQuote = sCommand[i]
        isInsideQuotes = true
        beginning += 1

    # Separate arguments
    elif sCommand[i] == ARGUMENT_SEPARATOR and !isInsideQuotes or i == sCommand.length() - 1:
      if i == sCommand.length() - 1:
        subString = sCommand.substr(beginning, i - beginning + 1)
      else:
        subString = sCommand.substr(beginning, i - beginning)
      beginning = i + 1

    # Separate commands
    elif sCommand[i] == COMMAND_SEPARATOR and !isInsideQuotes:
      subString = sCommand.substr(beginning, i - beginning)
      result.append({
        'name': null,
        'arguments': []
      })
      beginning = i + 1

    # Save separated argument
    if subString != null and typeof(subString) == TYPE_STRING and !subString.empty():
      if !result[currentCommand].name:
        result[currentCommand].name = subString
      else:
        result[currentCommand].arguments.append(subString)
      subString = null

      if sCommand[i] == COMMAND_SEPARATOR:
        currentCommand += 1

  return result
