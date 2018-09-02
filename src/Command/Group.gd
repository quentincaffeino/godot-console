
extends Reference

const Command = preload('Command.gd')
const CommandHandler = preload('CommandHandler.gd')


# @var  string
var _name

# @var  string
var _fullName

# @var  { [groupName: string]: Group }
var _groups

# @var  { [commandName: string]: Command }
var _commands


# @var  string       name
# @var  string|null  fullName
func _init(name, fullName = null):
  self._name = name
  self._fullName = fullName if fullName != null else name
  self._groups = {}
  self._commands = {}


func getName():  # string
  return self._name


func getFullName():  # string
  return self._fullName


# @var  Array  nameParts
# @var  bool   create
func _getGroup(nameParts, create = false):  # Group|null
  if nameParts.size():
    var firstNamePart = nameParts[0]
    nameParts.remove(0)

    if !self._groups.has(firstNamePart):
      if create:
        self._groups[firstNamePart] = get_script().new(firstNamePart, self.getFullName() + '.' + firstNamePart)
      else:
        var found = null
        var foundCount = 0

        for groupName in self._groups:
          if self._groups[groupName].getName().begins_with(firstNamePart):
            found = groupName
            foundCount += 1

        if foundCount == 1:
          firstNamePart = found
        else:
          Console.writeLine('TODO: error')  # TODO: Change to proper error desc

    if nameParts.size() > 1:
      return self._groups[firstNamePart]._getGroup(nameParts)

    return self._groups[firstNamePart]
  
  return null


# @var  string  name
# @var  Array   parameters
# @var  bool    register
func _getCommand(name, parameters = [], register = false):  # Command|null
  var nameParts = name.split('.', false)

  if nameParts.size():
    var lastNamePart = nameParts[nameParts.size() - 1]
    var group = self

    if nameParts.size() > 1:
      nameParts.remove(nameParts.size() - 1)
      group = self._getGroup(nameParts, register)  # Group|null
      
    if group:
      if register and !group._commands.has(lastNamePart):
        var command = Command.build(lastNamePart, parameters)  # Command|null

        if command:
          group._commands[lastNamePart] = command

      if group._commands.has(lastNamePart):
        return group._commands[lastNamePart]

      elif Console.submitAutocomplete:
        var found = null  # Command|null
        var foundCount = 0  # int

        for commandName in group._commands:
          if group._commands[commandName].getName().begins_with(lastNamePart):
            found = group._commands[commandName]
            foundCount += 1

        if foundCount == 1:
          return found
        else:
          Console.writeLine('TODO: error')  # TODO: Change to proper error desc

  return null


# @var  string  name
# @var  Array   parameters
func registerCommand(name, parameters = []):  # bool
  return self._getCommand(name, parameters, true) != null


# @var  string  name
func getCommand(name):  # CommandHandler|null
  var command = self._getCommand(name)  # Command|null

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
