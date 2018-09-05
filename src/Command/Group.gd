
extends Reference

const ArrayCollection = preload('../../vendor/quentincaffeino/array-utils/src/Collection.gd')
const Command = preload('Command.gd')
const CommandHandler = preload('CommandHandler.gd')


# @var  string
var _name

# @var  string
var _fullName

# @var  ArrayCollection<string, Group>
var _groups

# @var  ArrayCollection<string, Command>
var _commands


# @var  string       name
# @var  string|null  fullName
func _init(name, fullName = null):
  self._name = name
  self._fullName = fullName if fullName != null else name
  self._groups = ArrayCollection.new()
  self._commands = ArrayCollection.new()


func getName():  # string
  return self._name


func getFullName():  # string
  return self._fullName


func getGroups():  # ArrayCollection<string, Group>
  return self._groups


func getCommands():  # ArrayCollection<string, Command>
  return self._commands


# @var  Variant[]  nameParts
# @var  bool   create
func _getGroup(nameParts, create = false):  # Group|null
  if nameParts.size():
    var firstNamePart = nameParts[0]
    nameParts.remove(0)

    if !self.getGroups().containsKey(firstNamePart):
      if create:
        self.getGroups().set(firstNamePart, get_script().new(firstNamePart, self.getFullName() + '.' + firstNamePart))
      else:
        var found = null
        var foundCount = 0

        for groupName in self.getGroups():
          if self.getGroups().get(groupName).getName().begins_with(firstNamePart):
            found = groupName
            foundCount += 1

        if foundCount == 1:
          firstNamePart = found
        else:
          Console.writeLine('TODO: error')  # TODO: Change to proper error desc

    if nameParts.size() > 1:
      return self.getGroups().get(firstNamePart)._getGroup(nameParts)

    return self.getGroups().get(firstNamePart)
  
  return null


# @var  string     name
# @var  Variant[]  parameters
# @var  bool       register
func _getCommand(name, parameters = [], register = false):  # Command|null
  var nameParts = name.split('.', false)

  if nameParts.size():
    var lastNamePart = nameParts[nameParts.size() - 1]
    var group = self

    if nameParts.size() > 1:
      nameParts.remove(nameParts.size() - 1)
      group = self._getGroup(nameParts, register)  # Group|null
      
    if group:
      if register and !group.getCommands().containsKey(lastNamePart):
        var command = Command.build(lastNamePart, parameters)  # Command|null

        if command:
          group.getCommands().set(lastNamePart, command)

      if group.getCommands().containsKey(lastNamePart):
        return group.getCommands().get(lastNamePart)

      elif Console.submitAutocomplete:
        var found = null  # Command|null
        var foundCount = 0  # int

        for commandName in group.getCommands():
          if group.getCommands().get(commandName).getName().begins_with(lastNamePart):
            found = group.getCommands().get(commandName)
            foundCount += 1

        if foundCount == 1:
          return found
        else:
          Console.writeLine('TODO: error')  # TODO: Change to proper error desc

  return null


# @var  string     name
# @var  Variant[]  parameters
func registerCommand(name, parameters = []):  # bool
  return self._getCommand(name, parameters, true) != null


func unregisterCommand(name):
  var nameParts = name.split('.', false)

  if nameParts.size():
    var lastNamePart = nameParts[nameParts.size() - 1]
    var group = self

    if nameParts.size() > 1:
      nameParts.remove(nameParts.size() - 1)
      group = self._getGroup(nameParts)  # Group|null

    if group:
      if group.getCommands().containsKey(lastNamePart):
        group.getCommands().remove(lastNamePart)
        return true

      else:
        var found = null  # Command|null
        var foundCount = 0  # int

        for commandName in group.getCommands():
          if group.getCommands().get(commandName).getName().begins_with(lastNamePart):
            found = commandName
            foundCount += 1

        if foundCount == 1:
          group.getCommands().remove(found)
          return true
        else:
          Console.writeLine('TODO: error')  # TODO: Change to proper error desc

  return false


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
  for command in self.getCommands():
    self.getCommands().get(command).describe()

  # Print all commands in child groups
  for group in self.getGroups():
    self.getGroups().get(group).printAll()
