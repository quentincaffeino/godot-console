
extends Object


enum TYPE {
	INFO,
	WARNING,
	ERROR,
	NONE
}


# @var  int
var logLevel = WARNING setget setLogLevel


# @param  int  _logLevel
func setLogLevel(_logLevel = 0):  # void
	logLevel = _logLevel


# @param  int  type
# @param  string  message
func log(type, message):  # void
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
