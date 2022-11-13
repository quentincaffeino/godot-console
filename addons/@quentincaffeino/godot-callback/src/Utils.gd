
extends Reference


enum Type {
	UNKNOWN,
	PROPERTY,
	METHOD
}


# @param    Reference  target
# @param    String     name
# @returns  int
static func get_type(target, name):
	# Is it a METHOD
	if target.has_method(name):
		return Type.METHOD

	# Is it a PROPERTY
	if name in target:
		return Type.PROPERTY

	return Type.UNKNOWN


# NOTE: This addon requires call_funcv to work properly. Older engine versions
#       dont' have it. Should concider notifying developer in case that used
#       engine doesn't have this method.
# @param    Reference  obj
# @returns  bool
static func is_funcref(obj):
	return "function" in obj \
		and obj.has_method("set_function") \
		and obj.has_method("get_function") \
		and obj.has_method("call_func") \
		and obj.has_method("call_funcv") \
		and obj.has_method("is_valid") \
		and obj.has_method("set_instance")
