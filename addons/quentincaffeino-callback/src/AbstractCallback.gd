
extends Reference

const Utils = preload('./Utils.gd')
const errors = preload('../assets/translations/errors.en.gd').messages


# @var  Reference
var _target

# @var  Utils.Type
var _type


# @param  Reference   target
# @param  Utils.Type  type
func _init(target, type):
	self._target = target
	self._type = type


func getTarget():  # Reference
	return self._target


func getType():  # Utils.Type
	return self._type


# Ensure callback target exists
func ensure():  # boolean
	pass


# @param  Variant[]  argv
func call(argv = []):  # Variant
	pass
