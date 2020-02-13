
extends Reference

const Argument = preload('../Argument/Argument.gd')


# @var  string
var _name

# @var  Callback
var _target

# @var  Argument[]
var _arguments

# @var  string|null
var _description


# @param  string       name
# @param  Callback     target
# @param  Argument[]   arguments
# @param  string|null  description
func _init(name, target, arguments = [], description = null):
	self._name = name
	self._target = target
	self._arguments = arguments
	self._description = description


func getName():  # string
	return self._name


func getTarget():  # Callback
	return self._target


func getArguments():  # Argument[]
	return self._arguments


func getDescription():  # string|null
	return self._description


# @param  Variant[]  inArgs
func execute(inArgs = []):  # Variant
	var args = []
	var argAssig

	var i = 0
	while i < self._arguments.size() and i < inArgs.size():
		argAssig = self._arguments[i]\
			.setValue(inArgs[i])

		if argAssig == FAILED:
			Console.Log.warn(\
				'Expected ' + self._arguments[i].getType().describe() + \
				' ' + str(i + 1) + 'as argument.')
			return
		elif argAssig == Argument.ASSIGNMENT.CANCELED:
			return OK

		args.append(self._arguments[i].getValue())
		i += 1

	# Execute command
	return self._target.call(args)


func describe():  # void
	Console.write(\
		'[color=#ffff66][url=' + self._name + ']' + self._name + '[/url][/color]')

	if self._arguments.size() > 0:
		for arg in self._arguments:
			Console.write(' [color=#88ffff]' + arg.describe() + '[/color]')

	if _description:
		Console.write(' - ' + _description)

	Console.writeLine()
