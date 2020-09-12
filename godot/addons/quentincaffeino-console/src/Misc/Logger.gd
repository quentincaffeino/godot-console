
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


# @param  int  inlogLevel
func setLogLevel(inlogLevel):  # Log
	logLevel = inlogLevel
	return self


# @param  string  message
# @param  int     type
func log(message, type = TYPE.INFO):  # Log
	match type:
		TYPE.DEBUG:   debug(message)
		TYPE.INFO:    info(message)
		TYPE.WARNING: warn(message)
		TYPE.ERROR:   error(message)
	return self


# @param  string  message
func debug(message):  # Log
	if logLevel <= TYPE.DEBUG:
		Console.writeLine('[color=green][DEBUG][/color] ' + str(message))
	return self


# @param  string  message
func info(message):  # Log
	if logLevel <= TYPE.INFO:
		Console.writeLine('[color=blue][INFO][/color] ' + str(message))
	return self


# @param  string  message
func warn(message):  # Log
	if logLevel <= TYPE.WARNING:
		Console.writeLine('[color=yellow][WARNING][/color] ' + str(message))
	return self


# @param  string  message
func error(message):  # Log
	if logLevel <= TYPE.ERROR:
		Console.writeLine('[color=red][ERROR][/color] ' + str(message))
	return self
