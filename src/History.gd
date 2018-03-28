
extends Reference


# @param  Array<string>
var _history = []

# @param  int
var _current = -1


# @param  string  command
func push(command):  # void
  if _history.size() > 0 and _history[_history.size() - 1] == command:
    return

  _history.append(command)


func prev():  # string
  if _history.size() > 0 and _current < _history.size() - 1:
    _current += 1
    return _history[_history.size() - _current - 1]


func next():  # string
  if _history.size() > 0 and _current > 0:
    _current -= 1
    return _history[_history.size() - _current - 1]
  else:
    reset()


func reset():  # void
  _current = -1


func printAll():  # void
  for i in range(_history.size()):
    Console.writeLine(\
      '[b]' + str(i + 1) + '.[/b] [color=#ffff66][url=' + \
      _history[i] + ']' + _history[i] + '[/url][/color]')
