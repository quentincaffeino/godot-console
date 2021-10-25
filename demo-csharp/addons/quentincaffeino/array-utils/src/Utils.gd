
extends Reference


# @param    Variant  value
# @returns  Variant[]
static func to_array(value):
	if is_array(value):
		return value

	elif typeof(value) != TYPE_NIL:
		return [ value ]

	return []


# @param    Variant  value
# @returns  bool
static func is_array(value):
	return typeof(value) >= TYPE_ARRAY and typeof(value) <= TYPE_COLOR_ARRAY


# @param    Variant  value
# @returns  Dictionary
static func to_dict(value):
	if typeof(value) == TYPE_DICTIONARY:
		return value

	var d = {}

	if typeof(value) != TYPE_NIL:
		if is_array(value):
			for i in value.size():
				d[i] = value[i]
		else:
			d[0] = value

	return d


# @param    Variant[]  in_array
# @param    Variant[]  out_array
# @param    int        depth
# @returns  Variant[]
static func flatten(in_array, out_array = [], depth = -1):
	assert(typeof(in_array) == TYPE_ARRAY, "qc/array-utils: Utils: in_array must be an array")

	for i in in_array.size():
		if is_array(in_array[i]) and depth > 0:
			flatten(in_array[i], out_array, depth - 1)
		else:
			out_array.append(in_array[i])

	return out_array
