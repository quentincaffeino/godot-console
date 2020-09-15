
extends './AbstractCallback.gd'


# @var  string
var _name


# @param  Reference   target
# @param  string      name
# @param  Utils.Type  type
func _init(target, name, type = Utils.Type.UNKNOWN).(target, type if type != Utils.Type.UNKNOWN else Utils.getType(target, name)):
	self._name = name


func getName():  # string
	return self._name


# Ensure callback target exists
func ensure():  # boolean
	if self._target:
		var wr = weakref(self._target)
		if wr.get_ref() == null:
			print(errors['qc.callback.ensure.target_destroyed'] % self._name)
			return false
	else:
		print(errors['qc.callback.ensure.target_destroyed'] % self._name)
		return false

	if Utils.getType(self._target, self._name) == Utils.Type.UNKNOWN:
		print(errors['qc.callback.target_missing_mv'] % [ self._target, self._name ])
		return false

	return true


# @param  Variant[]  argv
func call(argv = []):  # Variant
	# Ensure callback target still exists
	if !ensure():
		print(errors['qc.callback.call.ensure_failed'] % [ self._target, self._name ])
		return

	argv = self._get_args(argv)

	# Execute call
	if self._type == Utils.Type.VARIABLE:
		if argv.size():
			self._target.set(self._name, argv[0])

		return self._target.get(self._name)

	elif self._type == Utils.Type.METHOD:
		return self._target.callv(self._name, argv)
	
	print(errors['qc.callback.call.unknown_type'] % [ self._target, self._name ])
