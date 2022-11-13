
extends './AbstractCallbackBuilder.gd'

const FuncRefCallback = preload("./FuncRefCallback.gd")


# @param  FuncRef  target
func _init(target).(target):
	pass

# @returns  FuncRefCallback
func build():
	return FuncRefCallback.new(self._target)
