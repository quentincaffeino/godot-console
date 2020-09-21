
extends Reference

const Iterator = preload('res://addons/quentincaffeino-console/addons/quentincaffeino-iterator/src/Iterator.gd')
const CommandCollection = preload('CommandCollection.gd')
const CommandBuilder = preload('CommandBuilder.gd')
const Result = preload('../Misc/Result.gd')


# @var  Console
var _console

# @var  CommandCollection
var _command_collection = CommandCollection.new()


# @param  Console  console
func _init(console):
	self._console = console


# @returns  Iterator
func values():
	return self._command_collection.getValueIterator()


# @param    String       command_name
# @param    Reference    target
# @param    String|null  target_name
# @returns  CommandBuilder
func create(command_name, target, target_name = null):
	return CommandBuilder.new(self._console, self, command_name, target, target_name)


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

# @param    String   command_name
# @returns  String
func autocomplete(command_name):
	var commands = self.find(command_name)

	if commands.length == 1:
		return commands.getByIndex(0).getName()

	var autocomplete_result_str = command_name
	var autocomplete_result_str_len = len(autocomplete_result_str)

	var letter
	var letter_i = autocomplete_result_str_len

	while commands.length:
		for command in commands.getValueIterator():
			var cmd_name = command.getName()
			
			if letter_i >= len(cmd_name):
				return autocomplete_result_str

			var compare_to_letter = cmd_name[letter_i]

			if not letter:
				letter = compare_to_letter

			if letter != compare_to_letter:
				return autocomplete_result_str

		autocomplete_result_str += letter
		autocomplete_result_str_len += 1
		letter = null
		letter_i += 1

	return command_name
