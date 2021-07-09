
extends Reference


enum Type \
{
	UNKNOWN,
	VARIABLE,
	METHOD
}


# @param    Reference  target
# @param    String     name
# @returns  int
static func get_type(target, name):
	# Is it a METHOD
	if target.has_method(name):
		return Type.METHOD

	# Is it a VARIABLE
	if name in target:
		return Type.VARIABLE

	return Type.UNKNOWN


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
