
extends 'res://vendor/quentincaffeino/array-utils/src/Collection.gd'


# @var  int
var _maxLength = 10


# @param  Command/CommandHandler  command
func push(command):  # void
  if self.length and self.last().getText() == command.getText():
    return

  if self.length == self._maxLength:
    self.removeByIndex(0)

  self.add(command)


func getMaxLength():  # int
  return self._maxLength


# @param  int  maxLength
func setMaxLength(maxLength):  # History
  self._maxLength = maxLength
  return self


func printAll():  # void
  var i = 1
  var commandText
  self.first()
  for key in self:
    commandText = self._collection[key].getText()
    Console.writeLine(\
      '[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
      commandText + ']' + commandText + '[/url][/color]')
    i += 1
