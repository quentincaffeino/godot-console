
extends Reference

const Utils = preload("./Utils.gd")
const Callback = preload("./Callback.gd")
const FuncRefCallback = preload("./FuncRefCallback.gd")
const errors = preload("../assets/translations/errors.en.gd").messages


# @var  Reference
var _target

# @var  String|null
var _name

# @var  int
var _type

# @var  Variant[]
var _bind_argv


# @param  Reference  target
func _init(target):
	self._target = target
	self._type = Utils.Type.UNKNOWN
	self._bind_argv = []


# @param    String  name
# @returns  CallbackBuilder
func set_name(name):
	self._name = name
	return self

# @returns  String
func get_name():
	return self._name

# @param    String  name
# @returns  CallbackBuilder
func set_variable(name):
	self._name = name
	self._type = Utils.Type.VARIABLE
	return self

# @param    String  name
# @returns  CallbackBuilder
func set_method(name):
	self._name = name
	self._type = Utils.Type.METHOD
	return self


# @param    int  type
# @returns  CallbackBuilder
func set_type(type):
	self._type = type
	return self

# @returns  int
func get_type():
	return self._type


# @param    Variant[]  argv
# @returns  CallbackBuilder
func bind(argv = []):
	self._bind_argv = argv
	return self


# @returns  Callback|null
func build():
	if typeof(self._target) != TYPE_OBJECT:
		print(errors["qc.callback.canCreate.first_arg"] % str(typeof(self._target)))
		return null

	if Utils.is_funcref(self._target):
		return FuncRefCallback.new(self._target)

	if typeof(self._name) != TYPE_STRING:
		print(errors["qc.callback.canCreate.second_arg"] % str(typeof(self._name)))
		return null

	if not self._type or self._type == Utils.Type.UNKNOWN:
		self._type = Utils.get_type(self._target, self._name)
		if self._type == Utils.Type.UNKNOWN:
			print(errors["qc.callback.target_missing_mv"] % [ self._target, self._name ])
			return null

	var callback = Callback.new(self._target, self._name, self._type)
	callback.bind(self._bind_argv)
	return callback
