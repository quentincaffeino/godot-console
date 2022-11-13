
extends Reference

const errors = preload("./messages.gd").errors


# @var  Reference
var _target


# @param  Reference  target
func _init(target):
	self._target = target


# @returns  Reference
func get_target():
	return self._target
