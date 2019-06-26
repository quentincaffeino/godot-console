
extends Reference

const ArrayCollection = preload('../../vendor/quentincaffeino/array-utils/src/Collection.gd')


# @var  Command
var _command

# @var  ArrayCollection<string, Variant>
var _arguments

# @var  string|null
var _text


# @param  Command  command
func _init(command):
  self._command = command
  self._arguments = ArrayCollection.new()


func getCommand():  # Command
  return self._command


func getArguments():  # ArrayCollection<string, Variant>
  return self._arguments

# @param  Array<Variant>  arguments
func setArguments(arguments):  # CommandHandler
  self._arguments.replaceCollection(arguments)
  return self

# @param  Variant  argument
func addArgument(argument):  # CommandHandler
  self._arguments.add(argument)
  return self


func getText():  # string|null
  return self._text

# @param  string  text
func setText(text):  # CommandHandler
  self._text = text
  return self


# @param  Command/CommandHandler  commandHandler
func compareTo(commandHandler):
  return self.getText() == commandHandler.getText()


func execute():  # Variant|null
  if self._command:
    return self._command.execute(self._arguments)

  return null
