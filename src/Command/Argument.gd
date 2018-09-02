
extends Reference

const TypesBuilder = preload('../Types/TypesBuilder.gd')
const BaseType = preload('../Types/BaseType.gd')


enum ASSIGNMENT \
{
  OK,
  FAILED,
  CANCELED
}


# @var  string
var _name

# @var  BaseType
var _type

# @var  string
var _originalValue


# @param  string|null  name
# @param  BaseType     type
func _init(name, type):
  self._name = name
  self._type = type


func getValue():  # Variant
  return self._type.getNormalizedValue()


# @param  Variant  value
func setValue(value):  # int
  self._originalValue = value

  var check = self._type.check(value)
  if check == OK:
    self._type.normalize(value)

  return check


func getOriginalValue():
  return self._originalValue


func describe():  # string
  var argumentName = ''

  if self._name:
    argumentName += self._name + ':'

  argumentName += self._type.toString()

  return argumentName


func getName():  # string
  return self._name


func getType():  # BaseType
  return self._type


# @param  string|null   name
# @param  int|BaseType  type
static func build(name, type = 0):  # Argument|int
  # Define arument type
  if !(typeof(type) == TYPE_OBJECT and type is BaseType):
    type = TypesBuilder.build(type if typeof(type) == TYPE_INT else 0)

  if not type is BaseType:
    Console.Log.error(\
      'QC/Console/Command/Argument: build: Argument of type [b]' + str(type) + '[/b] isn\'t supported.')
    return FAILED

  return new(name, type)


# @param  Array  args
static func buildAll(args):  # Argument[]|int
  # @var  Argument[]|int  builtArgs
  var builtArgs = []

  # @var  Argument|int|null  tempArg
  var tempArg
  for arg in args:
    tempArg = null

    match typeof(arg):
      # [ 'argName', BaseType|ARG_TYPE ]
      TYPE_ARRAY:
        tempArg = build(arg[0], arg[1] if arg.size() > 1 else 0)

      # 'argName'
      TYPE_STRING:
        tempArg = build(arg)

      # BaseType|ARG_TYPE
      TYPE_OBJECT, TYPE_INT:
        tempArg = build(null, arg)

    if typeof(tempArg) == TYPE_INT:
      return FAILED

    builtArgs.append(tempArg)

  return builtArgs
