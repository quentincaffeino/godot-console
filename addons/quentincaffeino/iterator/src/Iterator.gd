
extends Reference

const CallbackBuilder = preload("res://addons/quentincaffeino/callback/src/CallbackBuilder.gd")


# @var  Callback
var _object_get_value_cb

# @var  Callback
var _object_get_length_cb

# @var  int
var _iteration_current_index = 0

# @var  int
var length setget _set_readonly, length


# @param  Reference  target
# @param  String     get_value_field
# @param  String     get_length_field
func _init(target, get_value_field = "get", get_length_field = "size"):
	_object_get_value_cb = CallbackBuilder.new(target).set_name(get_value_field).build()
	_object_get_length_cb = CallbackBuilder.new(target).set_name(get_length_field).build()


# @returns  int
func length():
	return self._object_get_length_cb.call()


# @param    int  index
# @returns  Variant
func _get(index):
	return self._object_get_value_cb.call([index])


# Sets the internal iterator to the first element in the collection and returns this element.
# @returns  Variant|null
func first():
	if self.length:
		self._iteration_current_index = 0
		return self._get(self._iteration_current_index)

	return null


# Sets the internal iterator to the last element in the collection and returns this element.
# @returns  Variant|null
func last():
	if self.length:
		self._iteration_current_index = self.length - 1
		return self._get(self._iteration_current_index)

	return null


# Gets the current key/index at the current internal iterator position.
# @returns  Variant|null
func key():
	if self.length:
		return self._iteration_current_index

	return null


# Moves the internal iterator position to the next element and returns this element.
# @returns  Variant|null
func next():
	if self.length and self._iteration_current_index < self.length - 1:
		self._iteration_current_index += 1
		return self._get(self._iteration_current_index)

	return null


# Moves the internal iterator position to the previous element and returns this element.
# @returns  Variant|null
func previous():
	if self.length and self._iteration_current_index > 0:
		self._iteration_current_index -= 1
		return self._get(self._iteration_current_index)

	return null


# Gets the element of the collection at the current internal iterator position.
# @returns  Variant|null
func current():
	if self.length:
		return self._get(self._iteration_current_index)

	return null


# @override  _iter_init(?)
# @returns   bool
func _iter_init(arg):
	self._iteration_current_index = 0
	return self._iteration_current_index < self.length


# @override  _iter_next(?)
# @returns   bool
func _iter_next(arg):
	self._iteration_current_index += 1
	return self._iteration_current_index < self.length


# @override  _iter_get(?)
# @returns   Variant
func _iter_get(arg = null):
	return self._get(self._iteration_current_index)


# @returns  void
func _set_readonly(value):
	print("qc/iterator: Iterator: Attempted to set readonly value, ignoring.")
