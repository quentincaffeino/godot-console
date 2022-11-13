
extends "./AbstractCallback.gd"


# @var  String
var _name


# @param  Reference   target
# @param  String      name
# @param  Utils.Type  type
func _init(target, name, type = Utils.Type.UNKNOWN).(target, type if type != Utils.Type.UNKNOWN else Utils.get_type(target, name)):
	self._name = name


# @returns  String
func get_name():
	return self._name


# @param    Variant[]  argv
# @returns  self
func bind(argv = []):
	var cb = self.get_script().new(self._target, self._name, self._type)
	var bind_argv = self._bind_argv.duplicate()
	bind_argv.append_array(argv)
	cb._bind_argv = bind_argv
	return cb


# Ensure callback target exists
# @returns  bool
func ensure():
	if self._target:
		var wr = weakref(self._target)
		if wr.get_ref() == null:
			print(errors["ensure.target_destroyed"] % self._name)
			return false
	else:
		print(errors["ensure.target_destroyed"] % self._name)
		return false

	if Utils.get_type(self._target, self._name) == Utils.Type.UNKNOWN:
		print(errors["target_missing_member"] % [ self._target, self._name ])
		return false

	return true


# @param    Variant[]  argv
# @returns  Variant
func call(argv = []):
	# Ensure callback target still exists
	if !ensure():
		print(errors["call.ensure_failed"] % [ self._target, self._name ])
		return

	argv = self._get_args(argv)

	# Execute call
	if self._type == Utils.Type.PROPERTY:
		if argv.size():
			self._target.set(self._name, argv[0])

		return self._target.get(self._name)

	elif self._type == Utils.Type.METHOD:
		return self._target.callv(self._name, argv)

	print(errors["call.unknown_type"] % [ self._target, self._name ])
