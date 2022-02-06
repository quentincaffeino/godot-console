
extends Reference

const History = preload('./History.gd')


# @const  String
const _name = 'history'

# @var  Console
var _console

# @var  History
var _history


# @param  Console       console
# @param  History|null  history
func _init(console, history = null):
	self._console = console
	self._history = history if history else History.new(100)


# @returns  History
func get_history():
	return self._history


# @returns  HistoryService
func print_all():
	var entries = self._history.get_all()

	for entry in entries.resume():
		self._console.write_line(entry)

	return self


# @returns  String
static func get_name():
	return _name
