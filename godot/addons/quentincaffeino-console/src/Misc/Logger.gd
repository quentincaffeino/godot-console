
extends Reference


enum TYPE \
{
	DEBUG,
	INFO,
	WARNING,
	ERROR,
	NONE
}


# @var  int
var logLevel = TYPE.WARNING setget setLogLevel


# @param    int  inlogLevel
# @returns  Log
func setLogLevel(inlogLevel):
	logLevel = inlogLevel
	return self


# @param    String  message
# @param    int     type
# @returns  Log
func log(message, type = TYPE.INFO):
	match type:
		TYPE.DEBUG:   debug(message)
		TYPE.INFO:    info(message)
		TYPE.WARNING: warn(message)
		TYPE.ERROR:   error(message)
	return self


# @param    String  message
# @returns  Log
func debug(message):
	if logLevel <= TYPE.DEBUG:
		Console.writeLine('[color=green][DEBUG][/color] ' + str(message))
	return self


# @param    String  message
# @returns  Log
func info(message):
	if logLevel <= TYPE.INFO:
		Console.writeLine('[color=blue][INFO][/color] ' + str(message))
	return self


# @param    String  message
# @returns  Log
func warn(message):
	if logLevel <= TYPE.WARNING:
		Console.writeLine('[color=yellow][WARNING][/color] ' + str(message))
	return self


# @param    String  message
# @returns  Log
func error(message):
	if logLevel <= TYPE.ERROR:
		Console.writeLine('[color=red][ERROR][/color] ' + str(message))
	return self
