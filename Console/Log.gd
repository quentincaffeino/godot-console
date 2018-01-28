
extends Object


enum TYPE \
{
	INFO,
	WARNING,
	ERROR,
	NONE
}


# @var  int
var logLevel = WARNING setget setLogLevel


# @param  int  inlogLevel
func setLogLevel(inlogLevel = INFO):  # void
	logLevel = inlogLevel


# @param  string  message
# @param  int     type
func log(message, type = INFO):  # void
	match type:
		INFO:    info(message)
		WARNING: warn(message)
		ERROR:   error(message)


# @param  string  message
# @param  string  debugInfo
func info(message, debugInfo = ''):  # void
	if logLevel <= INFO:
		var write = '[color=blue][INFO][/color] '

		if Console.debugMode and debugInfo:
			write += str(debugInfo) + ': '

		Console.writeLine(write + str(message))


# @param  string  message
# @param  string  debugInfo
func warn(message, debugInfo = ''):  # void
	if logLevel <= WARNING:
		var write = '[color=yellow][WARNING][/color] '

		if Console.debugMode and debugInfo:
			write += str(debugInfo) + ': '

		Console.writeLine(write + str(message))


# @param  string  message
# @param  string  debugInfo
func error(message, debugInfo = ''):
	if logLevel <= ERROR:  # void
		var write = '[color=red][ERROR][/color] '

		if Console.debugMode and debugInfo:
			write += str(debugInfo) + ': '

		Console.writeLine(write + str(message))
