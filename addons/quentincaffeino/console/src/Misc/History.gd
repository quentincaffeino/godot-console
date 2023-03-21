
extends 'res://addons/quentincaffeino/array-utils/src/QueueCollection.gd'

## History is saved to disk when persistent is true
@export var persistent: bool = false: set = set_persistent
## History is saved to this file when persistent is true
@export_file("*.txt") var history_file_path = "user://console_history.txt"

var _history_file: FileAccess

# @param  int  maxLength
func _init(maxLength):
	self.set_max_length(maxLength)
	set_persistent(persistent)


# @returns  History
func print_all():
	var i = 1
	for command in self.get_value_iterator():
		Console.write_line(\
			'[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
			command + ']' + command + '[/url][/color]')
		i += 1

	return self


func push(value):
	if value != null and self.last() != value and value.strip_edges().length() > 0:
		if _history_file != null:
			_history_file.store_line(value)
			_history_file.flush()
		super.push(value)


func set_persistent(value: bool):
	if (value and _history_file == null):
		open_history_file()
	else:
		_history_file = null
	persistent = value


func open_history_file():
	if FileAccess.file_exists(history_file_path):
		_history_file = FileAccess.open(history_file_path, FileAccess.READ_WRITE)
	else:
		_history_file = FileAccess.open(history_file_path, FileAccess.WRITE) # creates the file

	if _history_file == null:
		push_warning("Failed to open \"%s\", Console history will not be persisted: FileAccess.open() returned Error %d" % [history_file_path, FileAccess.get_open_error()])
	else:
		var lines_added = 0
		while _history_file.get_position() < _history_file.get_length():
			var line = _history_file.get_line()
			if (line.strip_edges().length() > 0):
				super.push(line)
				lines_added += 1
		
		# This file-size limiting code is currently commented out because the Collection that History
		# is built from has bugs - the QueueCollection uses pop() to limit its size but pop() only
		# works the first time it's called, after that the Collection has no key for index 0 and
		# anything referencing index 0 breaks.
#		if lines_added > self.get_max_length():
#			# File has exceeded the history length, rewrite it with just the most recent commands
#			_history_file.close()
#			_history_file = FileAccess.open(history_file_path, FileAccess.WRITE) # empty file
#			for line in self.get_value_iterator():
#				_history_file.store_line(line)
#			_history_file.flush()
