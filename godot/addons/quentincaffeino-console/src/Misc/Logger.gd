
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
var logLevel = TYPE.WARNING


# @deprecated
# @param    int  in_log_level
# @returns  Log
func setLogLevel(in_log_level):
	Console.Log.warn("DEPRECATED: We're moving our api from camelCase to snake_case, please update this method to `set_log_level`. Please refer to documentation for more info.")
	return self.set_log_level(in_log_level)


# @param    int  in_log_level
# @returns  Log
func set_log_level(in_log_level):
	logLevel = in_log_level
	return self

# Example usage:
# ```gdscript
# Console.Log.log("Hello world!", Console.Log.TYPE.INFO)
# ```
#
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
		Console.write_line('[color=green][DEBUG][/color] ' + str(message))
	return self


# @param    String  message
# @returns  Log
func info(message):
	if logLevel <= TYPE.INFO:
		Console.write_line('[color=blue][INFO][/color] ' + str(message))
	return self


# @param    String  message
# @returns  Log
func warn(message):
	if logLevel <= TYPE.WARNING:
		Console.write_line('[color=yellow][WARNING][/color] ' + str(message))
	return self


# @param    String  message
# @returns  Log
func error(message):
	if logLevel <= TYPE.ERROR:
		Console.write_line('[color=red][ERROR][/color] ' + str(message))
	return self
