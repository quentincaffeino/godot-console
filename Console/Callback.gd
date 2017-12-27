
extends Object


enum TYPE {
	VARIABLE,
	METHOD
}


# @var  Object
var _target

# @var  string
var _name

# @var  int
var _type = -1


# @param  Object  target
# @param  string  name
func _init(target, name):
	_target = target
	_name = name
	_type = getType(_target, _name)


# @param  Array<Variant>  argv
func call(argv = []):  # Variant
	if typeof(argv) <= TYPE_ARRAY and typeof(argv) >= TYPE_COLOR_ARRAY:
		argv = [argv]

	if _type == VARIABLE:
		_target.set(_name, argv[0])
		return _target.get(_name)
	elif _type == METHOD:
		return _target.callv(_name, argv)


# @param  Object  target
# @param  string  name
static func create(target, name):  # Callback
	if typeof(target) != TYPE_OBJECT:
		Console.Log.error('First argument must be target object.')
		return FAILED

	if typeof(name) != TYPE_STRING:
		Console.Log.error('Second argument must be variable or method name.')
		return FAILED

	if getType(target, name) < 0:
		Console.Log.error('Target object doesn\'t have supplied method or variable')
		return FAILED

	return Console.Callback.new(target, name)


# @param  Object  target
# @param  string  name
static func getType(target, name):  # int
	# Check if it is METHOD type
	if target.has_method(name):
		return METHOD

	# Check if it is VARIABLE type
	var properties = target.get_property_list()

	for p in properties:
		if p.name == name:
			return VARIABLE

	return -1
