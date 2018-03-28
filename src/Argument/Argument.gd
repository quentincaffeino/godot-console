
extends Reference

const TypesBuilder = preload('../Types/TypesBuilder.gd')
const BaseType = preload('../Types/BaseType.gd')


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
  return _type.get()


func toString():  # string
  var result = ''

  if _name:
    result += _name + ':'

  result += _type.getName()

  return result


# @param  string|null   name
# @param  int|BaseType  type
static func build(name, type = 0):  # Argument|int
  # Define arument type
  if !(typeof(type) == TYPE_OBJECT and type is BaseType):
    type = TypesBuilder.build(type if typeof(type) == TYPE_INT else 0)

  if typeof(type) == TYPE_INT:
    return FAILED

  return new(name, type)


# @param  Array  args
static func buildAll(args):  # Array<Argument>|int
  var builtArgs = []

  var tArg
  for arg in args:
    match typeof(arg):
      TYPE_ARRAY:            tArg = build(arg[0], arg[1] if arg.size() > 1 else 0)
      TYPE_STRING:           tArg = build(arg)
      TYPE_OBJECT, TYPE_INT: tArg = build(null, arg)

    if typeof(tArg) == TYPE_INT:
      return FAILED

    builtArgs.append(tArg)

  return builtArgs
