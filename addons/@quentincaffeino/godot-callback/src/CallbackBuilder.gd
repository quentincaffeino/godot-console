
extends './AbstractCallbackBuilder.gd'

const Utils = preload("./Utils.gd")
const Callback = preload("./Callback.gd")
const FuncRefCallback = preload("./FuncRefCallback.gd")


# @var  String|null
var _name

# @var  Utils.Type
var _type


# @param  Reference  target
func _init(target).(target):
	pass

# @param    String  name
# @returns  CallbackBuilder
func set_name(name):
	self._name = name
	return self

# @returns  String
func get_name():
	return self._name


# @returns  Callback|null
func build():
	if typeof(self._name) != TYPE_STRING:
		print(errors["build.name"] % str(typeof(self._name)))
		return null

	var type = Utils.get_type(self._target, self._name)
	if type == Utils.Type.UNKNOWN:
		print(errors["target_missing_member"] % [ self._target, self._name ])
		return null

	var callback = Callback.new(self._target, self._name, type)
	return callback
