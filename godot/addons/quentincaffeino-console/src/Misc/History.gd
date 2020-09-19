
extends '../../addons/quentincaffeino-array-utils/src/QueueCollection.gd'


# @param  int  maxLength
func _init(maxLength):
	self.setMaxLength(maxLength)


# @returns  History
func print_all():
	var i = 1
	for command in self.getValueIterator():
		Console.write_line(\
			'[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
			command + ']' + command + '[/url][/color]')
		i += 1

	return self
