
## History is saved to disk when persistent is true
@export var persistent: bool = false: set = set_persistent
## History is saved to this file when persistent is true
@export_file("*.txt") var history_file_path = "user://console_history.txt"

var _history_file: FileAccess
var _collection: Array[String] = []
var _maxLength: int
var _currentIndex: int = -1;

# @param  int  maxLength
func _init(maxLength):
	_maxLength = maxLength
	set_persistent(persistent)


# @returns  History
func print_all():
	var i = 1
	for command in _collection:
		Console.write_line(\
			'[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
			command + ']' + command + '[/url][/color]')
		i += 1

	return self


func push(value):
	if value != null and _collection.back() != value and value.strip_edges().length() > 0:
		if _history_file != null:
			_history_file.store_line(value)
			_history_file.flush()
		
		_push_to_collection(value)

# private method
func _push_to_collection(value: String):
	_collection.push_back(value)

	while _collection.size() > _maxLength:
		_collection.pop_front()
	
	_currentIndex = _collection.size() - 1

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
				_push_to_collection(line)
				lines_added += 1
		
		# File-size limiting code
		if lines_added > _maxLength:
			# File has exceeded the history length, rewrite it with just the most recent commands
			_history_file.close()
			_history_file = FileAccess.open(history_file_path, FileAccess.WRITE) # empty file
			for line in _collection:
				_history_file.store_line(line)
			_history_file.flush()

# Moves the internal iterator position to the next element and returns this element.
# @returns  String|null
func next():
	if _currentIndex < _collection.size() - 1:
		_currentIndex += 1
		return _collection[_currentIndex]

	return null


# Moves the internal iterator position to the previous element and returns this element.
# @returns  String|null
func previous():
	if _currentIndex > 0:
		_currentIndex -= 1
		return _collection[_currentIndex]

	return null


# Gets the element of the collection at the current internal iterator position.
# @returns  String|null
func current():
	if _collection.size() > 0:
		return _collection[_currentIndex]

	return null
