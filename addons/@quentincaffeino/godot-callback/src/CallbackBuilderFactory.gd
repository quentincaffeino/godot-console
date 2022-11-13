
extends Reference


const errors = preload("./messages.gd").errors
const Utils = preload("./Utils.gd")
const CallbackBuilder = preload("./CallbackBuilder.gd")
const FuncRefCallbackBuilder = preload("./FuncRefCallbackBuilder.gd")


# @param    Reference  target
# @returns  CallbackBuilder|FuncRefCallbackBuilder
static func get_callback_builder(target):
	assert(_validate_target(target), errors["build_factory.target"] % str(typeof(target)))

	if Utils.is_funcref(target):
		return FuncRefCallbackBuilder.new(target)

	return CallbackBuilder.new(target)

# @param    Reference  target
# @returns  bool
static func _validate_target(target):
	return typeof(target) == TYPE_OBJECT
