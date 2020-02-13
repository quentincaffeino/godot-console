
extends '../../addons/quentincaffeino-array-utils/src/QueueCollection.gd'


# @param  int  maxLength
func _init(maxLength):
	self.setMaxLength(maxLength)


func printAll():  # History
	var i = 1
	for command in self.getValueIterator():
		Console.writeLine(\
			'[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
			command + ']' + command + '[/url][/color]')
		i += 1

	return self
