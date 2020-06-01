
extends Reference

const CallbackBuilder = preload('../../quentincaffeino-callback/src/CallbackBuilder.gd')


# @var  Callback
var _objectGetValueCb

# @var  Callback
var _objectGetLengthCb

# @var  int
var _iterationCurrentIndex = 0

# @var  int
var length setget _setProtected, length


# @param  Reference  target
# @param  string     getValueField
# @param  string     getLengthField
func _init(target, getValueField = 'get', getLengthField = 'size'):
	_objectGetValueCb = CallbackBuilder.new(target).setName(getValueField).build()
	_objectGetLengthCb = CallbackBuilder.new(target).setName(getLengthField).build()


func length():  # int
	return self._objectGetLengthCb.call()


# @param  int  index
func _get(index):  # Variant
	return self._objectGetValueCb.call([index])


# Sets the internal iterator to the first element in the collection and returns this element.
func first():  # Variant|null
	if self.length:
		self._iterationCurrentIndex = 0
		return self._get(self._iterationCurrentIndex)

	return null


# Sets the internal iterator to the last element in the collection and returns this element.
func last(): # Variant|null
	if self.length:
		self._iterationCurrentIndex = self.length - 1
		return self._get(self._iterationCurrentIndex)

	return null


# Gets the current key/index at the current internal iterator position.
func key():  # Variant|null
	if self.length:
		return self._iterationCurrentIndex

	return null


# Moves the internal iterator position to the next element and returns this element.
func next():  # Variant|null
	if self.length and self._iterationCurrentIndex < self.length - 1:
		self._iterationCurrentIndex += 1
		return self._get(self._iterationCurrentIndex)

	return null


# Moves the internal iterator position to the previous element and returns this element.
func previous():  # Variant|null
	if self.length and self._iterationCurrentIndex > 0:
		self._iterationCurrentIndex -= 1
		return self._get(self._iterationCurrentIndex)

	return null


# Gets the element of the collection at the current internal iterator position.
func current():  # Variant|null
	if self.length:
		return self._get(self._iterationCurrentIndex)

	return null


# @override _iter_init(?)
func _iter_init(arg):  # bool
	self._iterationCurrentIndex = 0
	return self._iterationCurrentIndex < self.length


# @override _iter_next(?)
func _iter_next(arg):  # bool
	self._iterationCurrentIndex += 1
	return self._iterationCurrentIndex < self.length


# @override _iter_get(?)
func _iter_get(arg = null):  # Variant
	return self._get(self._iterationCurrentIndex)


func _setProtected(value):  # void
	print('QC/Iterator/Iterator: Attempted to set protected value, ignoring.')
