
extends Reference


func _init():
  Console.register('echo', {
    'description': 'Prints a string in console',
    'args': [TYPE_STRING],
    'target': [Console, 'writeLine']
  })

  Console.register('history', {
    'description': 'Print all previous commands used during the session',
    'target': [Console._History, 'printAll']
  })

  Console.register('commands', {
    'description': 'Lists all available commands',
    'target': [Console._Commands, 'printAll']
  })

  Console.register('help', {
    'description': 'Outputs usage instructions',
    'args': [TYPE_STRING],
    'target': self
  })

  Console.register('quit', {
    'description': 'Exit application',
    'target': self
  })

  Console.register('clear', {
    'description': 'Clear the terminal',
    'target': Console
  })

  Console.register('version', {
    'description': 'Shows engine vesion',
    'target': self
  })

  Console.register('fps_max', {
    'args': [Console.IntRange.new(10, 1000)],
    'description': 'The maximal framerate at which the application can run',
    'target': [Engine, 'set_target_fps'],
  })


# @param  string|null  command
static func help(command = null):
  if command:
    var Command = Console._Commands.get(command)

    if !Command:
      Console.Log.warn('No such command')
      return

    Command.describe()
  else:
    Console.writeLine(\
      "Type [color=#ffff66][url=help]help[/url] <command-name>[/color] show information about command.\n" + \
      "Type [color=#ffff66][url=commands]commands[/url][/color] to get a list of all commands.\n" + \
      "Type [color=#ffff66][url=quit]quit[/url][/color] to exit the application.")


static func version():  # void
  Console.writeLine(Engine.get_version_info())


# This function is called from scripts/console_commands.gd to avoid the
# "Cannot access self without instance." error
static func quit():  # void
  Console.Log.warn('Quitting application...')
  Console.get_tree().quit()
