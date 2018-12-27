
extends Reference
# TODO: As soon as GVen will be finished create log package


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
func setLogLevel(inlogLevel = INFO):  # Log
  logLevel = inlogLevel
  return self


# @param  string  message
# @param  int     type
func log(message, type = INFO):  # Log
  match type:
    INFO:    info(message)
    WARNING: warn(message)
    ERROR:   error(message)
  return self


# @param  string  message
func info(message):  # Log
  if logLevel <= INFO:
    Console.writeLine('[color=blue][INFO][/color] ' + str(message))
  return self


# @param  string  message
func warn(message):  # Log
  if logLevel <= WARNING:
    Console.writeLine('[color=yellow][WARNING][/color] ' + str(message))
  return self


# @param  string  message
func error(message):  # Log
  if logLevel <= ERROR:
    Console.writeLine('[color=red][ERROR][/color] ' + str(message))
  return self
