
extends Object


# @var  Dictionary
const _messages = {
	# Commands
	'5': 'Command already exists.',

	# Command
	'10': 'Missing parametr [b]type[/b].',
	'11': 'Wrong type',
	'12': 'Missing parametr [b]name[/b]',
	'13': 'Missing [b]arguments[/b] parametr',
	'14': 'Wrong [b]arguments[/b] parametr',
	'15': 'Missing parametr [b]target[/b]',
}


# @var  Dictionary
const _offsets = {
	'Commands': 5,
	'Command': 10,
}


# @param  int  messageId
# @param  string  type
func get(messageId, type):
	return _messages[str(_offsets[type] + messageId)]
