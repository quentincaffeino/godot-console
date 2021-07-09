
extends Reference

const Utils = preload("./Utils.gd")
const errors = preload("../assets/translations/errors.en.gd").messages


# @var  Reference
var _target

# @var  Utils.Type
var _type

# @var  Variant[]
var _bind_argv


# @param  Reference   target
# @param  Utils.Type  type
func _init(target, type):
	self._target = target
	self._type = type
	self._bind_argv = []


# @returns  Reference
func get_target():
	return self._target


# @returns  int
func get_type():
	return self._type


# Ensure callback target exists
# @returns  boolean
func ensure():
	pass


# @param  Variant[]  argv
# @returns  void
func bind(argv = []):
	for _argv in argv:
		self._bind_argv.append(_argv)


# @param  Variant[]  argv
# @returns  Variant
func call(argv = []):
	pass


# @param    Variant[]  argv
# @returns  Variant[]
func _get_args(args = []):
	var new_args = self._bind_argv.duplicate()

	for arg in args:
		new_args.append(arg)

	return new_args
