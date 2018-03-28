
extends Reference


enum CHECK \
{
  CANCELED = 2
}


# @var  string
var _name

# @var  int
var _type = -1

# @var  RegExMatch
var _rematch


# Assignment check.
# Returns one of the statuses:
# OK, FAILED and CANCELED
#
# @param  Varian  value
func check(value):  # int
  var regex = Console.RegExLib.get(_type)

  if regex and regex is RegEx:
    _rematch = regex.search(value)

    if _rematch and _rematch is RegExMatch:
      return OK

  return FAILED


# Returns assigned variable
func get():  # Variant
  pass


func getName():  # string
  return _name
