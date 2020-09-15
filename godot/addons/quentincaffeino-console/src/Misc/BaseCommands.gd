
extends Reference


func _init():
	Console.addCommand('echo', Console, 'write')\
		.setDescription('Prints a string.')\
		.addArgument('text', TYPE_STRING)\
		.register()

	Console.addCommand('history', Console.History, 'printAll')\
		.setDescription('Print all previous commands used during the session.')\
		.register()

	Console.addCommand('commands', self, '_list_commands')\
		.setDescription('Lists all available commands.')\
		.register()

	Console.addCommand('help', self)\
		.setDescription('Outputs usage instructions.')\
		.addArgument('command', TYPE_STRING)\
		.register()

	Console.addCommand('quit', self)\
		.setDescription('Exit application.')\
		.register()

	Console.addCommand('clear', Console)\
		.setDescription('Clear the terminal.')\
		.register()

	Console.addCommand('version', self)\
		.setDescription('Shows engine vesion.')\
		.register()

	Console.addCommand('fps_max', Engine, 'set_target_fps')\
		.setDescription('The maximal framerate at which the application can run.')\
		.addArgument('fps', Console.IntRangeType.new(10, 1000))\
		.register()


# Display help message or display description for the command.
# @param    String|null  command_name
# @returns  void
static func help(command_name = null):
	if command_name:
		var command = Console.getCommand(command_name)

		if command:
			command.describe()
		else:
			Console.Log.warn('No help for `' + command_name + '` command were found.')

	else:
		Console.writeLine(\
			"Type [color=#ffff66][url=help]help[/url] <command-name>[/color] show information about command.\n" + \
			"Type [color=#ffff66][url=commands]commands[/url][/color] to get a list of all commands.\n" + \
			"Type [color=#ffff66][url=quit]quit[/url][/color] to exit the application.")


# Prints out engine version.
# @returns  void
static func version():
	Console.writeLine(Engine.get_version_info())


# @returns  void
static func _list_commands():
	for command in Console._command_service.values():
		var name = command.getName()
		Console.writeLine('[color=#ffff66][url=%s]%s[/url][/color]' % [ name, name ])


# Quitting application.
# @returns  void
static func quit():
	Console.Log.warn('Quitting application...')
	Console.get_tree().quit()
