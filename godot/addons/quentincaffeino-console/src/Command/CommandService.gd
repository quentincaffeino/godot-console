
extends Reference

const Iterator = preload('res://addons/quentincaffeino-console/addons/quentincaffeino-iterator/src/Iterator.gd')
const CommandCollection = preload('CommandCollection.gd')
const CommandBuilder = preload('CommandBuilder.gd')


var _command_collection = CommandCollection.new()


# @returns  Iterator
func values():
	return self._command_collection.getValueIterator()


# @param    String       command_name
# @param    Reference    target
# @param    String|null  target_name
# @returns  CommandBuilder
func create(command_name, target, target_name = null):
	return CommandBuilder.new(self, command_name, target, target_name)


# @param    String   command_name
# @param    Command  command
# @returns  bool
func set(command_name, command):
	if !self._command_collection.containsKey(command_name):
		self._command_collection.set(command_name, command)
		return true
	else:
		return false

# @param    String   command_name
# @returns  Command|null
func get(command_name):
	return self._command_collection.get(command_name)

# @param    String   command_name
# @returns  CommandCollection
func find(command_name):
	return self._command_collection.find(command_name)

# @param    String   command_name
# @returns  void
func remove(command_name):
	return self._command_collection.remove(command_name)
