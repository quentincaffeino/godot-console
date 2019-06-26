
extends '../../vendor/quentincaffeino/array-utils/src/Collection.gd'


# @var  int
var _maxLength = 10


# @param  string  command
func push(command):  # History
  if self.length and self.last() == command:
    return

  if self.length == self.getMaxLength():
    self.removeByIndex(0)

  self.add(command)
  self.last()
  return self


func getMaxLength():  # int
  return self._maxLength

# @param  int  maxLength
func setMaxLength(maxLength):  # History
  self._maxLength = maxLength
  return self


func printAll():  # History
  var i = 1
  var commandText
  self.first()

  for key in self:
    commandText = self._collection[key]

    Console.writeLine(\
      '[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
      commandText + ']' + commandText + '[/url][/color]')
    i += 1

  return self
