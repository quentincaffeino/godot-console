
extends Reference

const Argument = preload('../Argument/Argument.gd')


# @var  String
var _name

# @var  Callback
var _target

# @var  Argument[]
var _arguments

# @var  String|null
var _description


# @param  String       name
# @param  Callback     target
# @param  Argument[]   arguments
# @param  String|null  description
func _init(name, target, arguments = [], description = null):
	self._name = name
	self._target = target
	self._arguments = arguments
	self._description = description


# @returns  String
func getName():
	return self._name


# @returns  Callback
func getTarget():
	return self._target


# @returns  Argument[]
func getArguments():
	return self._arguments


# @returns  String|null
func getDescription():
	return self._description


# @param    Array  inArgs
# @returns  Variant
func execute(inArgs = []):
	var args = []
	var argAssig

	var i = 0
	while i < self._arguments.size() and i < inArgs.size():
		argAssig = self._arguments[i].set_value(inArgs[i])

		if argAssig == FAILED:
			Console.Log.warn(\
				'Expected %s %s as argument.' % [self._arguments[i].get_type().to_string(), str(i + 1)])
			return
		elif argAssig == Argument.ASSIGNMENT.CANCELED:
			return OK

		args.append(self._arguments[i].get_normalized_value())
		i += 1

	# Execute command
	return self._target.call(args)


# @returns  void
func describe():
	Console.write_line('NAME')
	Console.write_line(self._get_command_name())
	Console.write_line()

	Console.write_line('USAGE')
	Console.write(self._get_command_name())

	if self._arguments.size() > 0:
		for arg in self._arguments:
			Console.write(' [color=#88ffff]%s[/color]' %  arg.describe())

	Console.write_line()
	Console.write_line()

	if self._description:
		Console.write_line('DESCRIPTION')
		Console.write_line('	' + self._description)

	Console.write_line()

# @returns  String
func _get_command_name():
	return '	[color=#ffff66][url=%s]%s[/url][/color]' % [self._name, self._name]
