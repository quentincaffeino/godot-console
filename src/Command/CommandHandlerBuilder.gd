
extends Reference

const CommandHandler = preload('CommandHandler.gd')


# @param  string                                 commandName
# @param  ArrayCollection<string, Variant>|null  arguments
static func build(commandName, arguments = null):  # CommandHandler|null
  var command = Console.getCommand(commandName)

  if command:
    var commandHandler = CommandHandler.new(command)
    commandHandler.setArguments(arguments)
    return CommandHandler

  return null
