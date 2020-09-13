
extends Reference

const ArrayCollection = preload('../../addons/quentincaffeino-array-utils/src/Collection.gd')
const CommandBuilder = preload('CommandBuilder.gd')


# @var  String
var _name

# @var  ArrayCollection<String, CommandGroup>
var _groups

# @var  ArrayCollection<String, Command>
var _commands


# @param  String  name
func _init(name):
	self._name = name
	self._groups = ArrayCollection.new()
	self._commands = ArrayCollection.new()


# @returns  String
func getName():
	return self._name


# @returns  ArrayCollection<String, CommandGroup>
func getGroups():
	return self._groups


# @returns  ArrayCollection<String, Command>
func getCommands():
	return self._commands


# @param    Array  nameParts
# @param    bool   create
# @returns  CommandGroup|null
func _getGroup(nameParts, create = false):
	if nameParts.size():
		var firstNamePart = nameParts[0]
		nameParts.remove(0)

		if !self.getGroups().containsKey(firstNamePart):
			if create:
				self.getGroups().set(firstNamePart, get_script().new(firstNamePart))
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
					Console.Log.error('CommandGroup: _getGroup: TODO: error')  # TODO: Change to proper error desc

		if nameParts.size() > 1:
			return self.getGroups().get(firstNamePart)._getGroup(nameParts)

		return self.getGroups().get(firstNamePart)
	
	return null


# @param    String  name
# @param    Array   parameters
# @param    bool    register
# @returns  Command|null
func _getCommand(name, parameters = [], register = false):
	var nameParts = name.split('.', false)

	if nameParts.size():
		var lastNamePart = nameParts[nameParts.size() - 1]
		var group = self
		if nameParts.size() > 1:

			nameParts.remove(nameParts.size() - 1)
			group = self._getGroup(nameParts, register)  # CommandGroup|null

		if group:
			if register and !group.getCommands().containsKey(lastNamePart):
				var command = CommandBuilder.buildDeprecated(lastNamePart, parameters)  # Command|int

				if typeof(command) != TYPE_INT:
					group.getCommands().set(lastNamePart, command)
					Console.Log.info('Successfuly registered new command [b]`' + name + '`[/b].')

			if group.getCommands().containsKey(lastNamePart):
				Console.Log.debug('Successfuly found exsting command [b]`' + name + '`[/b].')
				return group.getCommands().get(lastNamePart)

			# elif Console.submitAutocomplete:
			# 	var found = null  # Command|null
			# 	var foundCount = 0  # int

			# 	for commandName in group.getCommands():
			# 		if group.getCommands().get(commandName).getName().begins_with(lastNamePart):
			# 			found = group.getCommands().get(commandName)
			# 			foundCount += 1

			# 	if foundCount == 1:
			# 		return found
			# 	else:
			# 		Console.Log.error('CommandGroup: _getCommand: Unable to provide with proper autocomplete.')

	return null


# @param    String  name
# @param    Array   parameters
# @returns  bool
func registerCommand(name, parameters = []):
	return self._getCommand(name, parameters, true) != null


func unregisterCommand(name):
	var nameParts = name.split('.', false)

	if nameParts.size():
		var lastNamePart = nameParts[nameParts.size() - 1]
		var group = self

		if nameParts.size() > 1:
			nameParts.remove(nameParts.size() - 1)
			group = self._getGroup(nameParts)  # CommandGroup|null

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
					Console.Log.error('CommandGroup: unregisterCommand:TODO: error')  # TODO: Change to proper error desc

	return false


# @param    String  name
# @returns  Command|null
func getCommand(name):
	return self._getCommand(name)


# @returns  void
func printAll():
	# Print all commands in current group
	for command in self.getCommands().getValueIterator():
		command.describe()

	# Print all commands in child groups
	for group in self.getGroups().getValueIterator():
		group.printAll()
