
extends Reference


# @var  String
var _filter = null

# @var  PoolStringArray
var _filtered = []

# @var  int
var _current = -1


# @param    String  filter
# @returns  void
func filter(filter):
	if _filter == filter:
		return

	var willBeFiltered = Console._Commands._commands
	# Little optimization to filter from already filtered if...
	if _filter and filter.length() > _filter.length() and filter.begins_with(_filter):
		willBeFiltered = _filtered

	_filter = filter

	# Filter commands
	for command in willBeFiltered:
		if command.begins_with(filter):
			_filtered.append(command)


# @returns  String
func next():
	if _filtered.size() > 0:
		if _current == _filtered.size() - 1:
			_current = -1

		_current += 1

		return _filtered[_current]
	else:
		reset()


# @returns  void
func reset():
	_filter = null
	_filtered = []
	_current = -1
