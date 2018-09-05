
extends Reference

const ArrayUtils = preload('../vendor/quentincaffeino/array-utils/src/Utils.gd')


enum TYPE \
{
	UNKNOWN,
	VARIABLE,
	METHOD
}

# @var  Reference
var _target

# @var  string
var _name

# @var  int
var _type


# @param  Reference  target
# @param  string     name
# @param  int        type
func _init(target, name, type = UNKNOWN):
	_target = target
	_name = name

	if type == UNKNOWN:
		type = getType(_target, _name)

	_type = type


func getTarget():  # Reference
	return _target


func getName():  # string
	return _name


# Ensure callback target still exists
func ensure():  # bool
	if _target:
		var wr = weakref(_target)
		if wr.get_ref() == null:
			print('QC/Callback: ensure: Failed to call a callback, target was previously destroyed. (%s)' % _name)
			return false
	else:
		print('QC/Callback: ensure: Failed to call a callback, target was previously destroyed. (%s)' % _name)
		return false

	if getType(_target, _name) == UNKNOWN:
		print('QC/Callback: ensure: Target is missing method/variable. (%s, %s)' % [_target, _name])
		return false

	return true


# @param  Variant[]  argv
func call(argv = []):  # Variant
	argv = ArrayUtils.toArray(argv)

	# Ensure callback target still exists
	if !ensure():
		return

	# Execute call
	if _type == VARIABLE:
		_target.set(_name, argv[0])
		return _target.get(_name)

	elif _type == METHOD:
		return _target.callv(_name, argv)
	
	print('QC/Callback: call: Unable to call unknown type.')


# Use this method before creating a callback
#
# @param  Reference  target
# @param  string     name
# @param  int        type
static func canCreate(target, name, type = UNKNOWN):  # int
	if typeof(target) != TYPE_OBJECT:
		print('QC/Callback: can_create: First argument must be target object. Provided: ' + str(typeof(target)))
		return UNKNOWN

	if typeof(name) != TYPE_STRING:
		print('QC/Callback: can_create: Second argument must be variable or method name. Provided: ' + str(typeof(name)))
		return UNKNOWN

	if type <= UNKNOWN or type > TYPE.size():
		type = getType(target, name)

		if type == UNKNOWN:
			print('QC/Callback: can_create: Target object doesn\'t have supplied method or variable.')

	return type


# @param  Reference  target
# @param  string     name
static func getType(target, name):  # int
	# Is it a METHOD
	if target.has_method(name):
		return METHOD

	# Is it a VARIABLE
	if name in target:
		return VARIABLE

	return UNKNOWN
