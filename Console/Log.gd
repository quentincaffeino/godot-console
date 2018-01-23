
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
func info(message):  # void
	if logLevel <= INFO:
		Console.writeLine('[color=blue][INFO][/color] ' + message)


# @param  string  message
func warn(message):  # void
	if logLevel <= WARNING:
		Console.writeLine('[color=yellow][WARNING][/color] ' + message)


# @param  string  message
func error(message):
	if logLevel <= ERROR:  # void
		Console.writeLine('[color=red][ERROR][/color] ' + message)
