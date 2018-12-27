
extends Reference

enum ARGASSIG \
{
  CANCELED = 2
}

# @var  string
var _name

# @var  BaseType
var _type

# @var  Variant
var value = null setget setValue, getValue


# @param  string|null  name
# @param  BaseType     type
func _init(name, type):
  _name = name
  _type = type


# @param  Variant  inValue
func setValue(inValue):  # int
  return _type.check(inValue)


func getValue():  # Variant
  return _type.fetch()


func toString():  # string
  var result = ''

  if _name:
    result += _name + ':'

  result += _type.getName()

  return result



