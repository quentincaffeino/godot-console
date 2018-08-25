
extends Reference

const Command = preload('Command.gd')
const CommandHandler = preload('CommandHandler.gd')


# @var  string
var _name

# @var  string
var _fullName

# @var  Dictionary<Group>
var _groups

# @var  Dictionary<Command>
var _commands


# @var  string  name
# @var  string  fullName
func _init(name, fullName):
  self._name = name
  self._fullName = fullName
  self._groups = {}
  self._commands = {}


func getName():  # string
  return self._name


func getFullName():  # string
  return self._fullName


# @var  Array  nameParts
func _getGroup(nameParts):  # Group
  if nameParts.size():
    var firstNamePart = nameParts[0]

    if !self._groups.has(firstNamePart):
      self._groups[firstNamePart] = get_script().new(firstNamePart, self.getFullName() + '.' + firstNamePart)

    if nameParts.size() > 1:
      nameParts.remove(0)
      return self._groups[firstNamePart]._getGroup(nameParts)

    return self._groups[firstNamePart]
  
  return self


# @var  string      name
# @var  Dictionary  parameters
# @var  bool        register
func _getCommand(name, parameters = [], register = false):  # Command|null
  var nameParts = name.split('.', false)

  if nameParts.size():
    var lastNamePart = nameParts[nameParts.size() - 1]
    var group = self

    if nameParts.size() > 1:
      nameParts.remove(nameParts.size() - 1)
      group = self._getGroup(nameParts)

    if register and !group._commands.has(lastNamePart):
      group._commands[lastNamePart] = Command.build(lastNamePart, parameters)

    if group._commands.has(lastNamePart):
      return group._commands[lastNamePart]

  return null


# @var  string      name
# @var  Dictionary  parameters
func registerCommand(name, parameters):  # bool
  return self._getCommand(name, parameters, true) != null


# @var  string  name
func getCommand(name):  # CommandHandler|null
  var command = self._getCommand(name)

  if command:
    return CommandHandler.new(command)
  else:
    Console.Log.warn('Command [b]`' + name + '`[/b] doesn\'t exists.')

  return null


func printAll():  # void
  # Print all commands in current group
  for command in self._commands:
    self._commands[command].describe()

  # Print all commands in child groups
  for group in self._groups:
    self._groups[group].printAll()
