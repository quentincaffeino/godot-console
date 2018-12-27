
extends Reference


# @var  Command|null
var _command

# @var  Variant[]
var _arguments

# @var  string|null
var _text


# @param  Command  command
func _init(command):
  self._command = command
  self._arguments = []


func getCommand():  # Command|null
  return self._command


func execute():  # Variant|null
  if self._command:
    return self._command.execute(self._arguments)
  return null


func getArguments():  # Variant[]
  return self._arguments


# @param  Variant[]  arguments
func setArguments(arguments):  # CommandHandler
  self._arguments = arguments
  return self


func getText():  # string|null
  return self._text


# @param  string  text
func setText(text):  # CommandHandler
  self._text = text
  return self
