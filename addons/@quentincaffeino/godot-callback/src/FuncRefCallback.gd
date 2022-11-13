
extends "./AbstractCallback.gd"


# @param  FuncRef  target
func _init(target).(target, Utils.Type.METHOD):
	pass


# @param    Variant[]  argv
# @returns  self
func bind(argv = []):
	var cb = self.get_script().new(self._target)
	var bind_argv = self._bind_argv.duplicate()
	bind_argv.append_array(argv)
	cb._bind_argv = bind_argv
	return cb


# Ensure callback target exists
# @returns  bool
func ensure():
	return self._target.is_valid()


# @param    Variant[]  argv
# @returns  Variant
func call(argv = []):
	# Ensure callback target still exists
	if !ensure():
		print(errors["call.ensure_failed"] % [ self._target ])
		return

	# Execute call
	return self._target.call_funcv(self._get_args(argv))
