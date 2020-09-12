
extends Reference

const Utils = preload('./Utils.gd')
const Callback = preload('./Callback.gd')
const FuncRefCallback = preload('./FuncRefCallback.gd')
const errors = preload('../assets/translations/errors.en.gd').messages
 

# @var  Reference
var _target

# @var  string|null
var _name

# @var  int
var _type


# @param  Reference  target
func _init(target):
	self._target = target


# @param  string  name
func setName(name):  # CallbackBuilder
	self._name = name
	return self


func build():  # Callback|null
	if typeof(self._target) != TYPE_OBJECT:
		print(errors['qc.callback.canCreate.first_arg'] % str(typeof(self._target)))
		return null

	if Utils.isFunkRef(self._target):
		return FuncRefCallback.new(self._target)

	if typeof(self._name) != TYPE_STRING:
		print(errors['qc.callback.canCreate.second_arg'] % str(typeof(self._name)))
		return null

	var type = Utils.getType(self._target, self._name)
	if type == Utils.Type.UNKNOWN:
		print(errors['qc.callback.target_missing_mv'] % [ self._target, self._name ])
		return null

	return Callback.new(self._target, self._name)
