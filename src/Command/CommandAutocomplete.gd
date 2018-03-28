
extends Reference


# @var  string
var _filter = null

# @var  Array<string>
var _filtered = []

# @param  int
var _current = -1


# @param  string  filter
func filter(filter):  # void
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


func next():  # string
  if _filtered.size() > 0:
    if _current == _filtered.size() - 1:
      _current = -1

    _current += 1

    return _filtered[_current]
  else:
    reset()


func reset():  # void
  _filter = null
  _filtered = []
  _current = -1
