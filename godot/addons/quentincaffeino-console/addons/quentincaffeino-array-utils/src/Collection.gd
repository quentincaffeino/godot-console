
extends 'Utils.gd'

const Iterator = preload('../../quentincaffeino-iterator/src/Iterator.gd')


# @var  Dictionary
var _collection

# @var  int
var _iterationCurrent = 0

# @var  int
var length setget _setProtected, length


# @param  Variant  collection
func _init(collection = {}):
	self.replaceCollection(collection)


# @param  Variant  collection
func replaceCollection(collection):  # void
	self._collection = self.toDict(collection)


# Adds/sets an element in the collection at the index / with the specified key.
# @param  Variant  key
# @param  Variant  value
func set(key, value):  # void
	self._collection[key] = value


# Adds an element to the collection.
# @param  Variant  value
func add(value):  # void
	self.set(self.length, value)


# Removes an element with a specific key/index from the collection.
# @param  Variant  key
func remove(key):  # void
	self._collection.erase(key)


# Removes the specified element from the collection, if it is found.
# @param  Variant  element
func removeElement(element):  # bool
	for key in self._collection:
		if self._collection[key] == element:
			self._collection.erase(key)
			return true

	return false


# @param  int  index
func removeByIndex(index):  # void
	var keys = self._collection.keys()

	if index >= 0 and index < keys.size():
		self._collection.erase(keys[index])


# Checks whether the collection contains a specific key/index.
# @paramm  Variant  key
func containsKey(key):  # bool
	return self._collection.has(key)


# Checks whether the given element is contained in the collection.
# Only element values are compared, not keys. The comparison of
# two elements is strict, that means not only the value but also
# the type must match. For objects this means reference equality.
# @param  Variant  element
func contains(element):  # bool
	for key in self._collection:
		if self._collection[key] == element:
			return true

	return false


# Searches for a given element and, if found, returns the corresponding
# key/index of that element. The comparison of two elements is strict,
# that means not only the value but also the type must match.
# For objects this means reference equality.
# @param  Variant  element
func indexOf(element):  # Variant|null
	for key in self._collection:
		if self._collection[key] == element:
			return key

	return null


# Gets the element with the given key/index.
# @param  Variant  key
func get(key):  # Variant|null
	if self.containsKey(key):
		return self._collection[key]

	return null


# @param  int  index
func getByIndex(index):  # Variant|null
	var keys = self._collection.keys()

	if index >= 0 and index < keys.size():
		return self._collection[keys[index]]

	return null


# Gets all keys/indexes of the collection elements.
func getKeys():  # Variant[]
	return self._collection.keys()


# Gets all elements.
func getValues():  # Variant[]
	return self._collection.values()


# Checks whether the collection is empty.
func isEmpty():  # bool
	return self.length == 0


# Clears the collection.
func clear():  # void
	self._collection = {}


# Extract a slice of `length` elements starting at
# position `offset` from the Collection.
# @param  int       offset
# @param  int|null  length
func slice(offset, length = null):  # Collection
	var result = get_script().new()

	if offset < self.length:
		if length == null:
			length = self.length

		var i = 0
		while length and i < self.length:
			result.set( i, self.getByIndex(offset + i) )
			length -= 1
			i += 1

	return result


# Fill an array with values.
# @param  Variant   value
# @param  int       startIndex
# @param  int|null  length
func fill(value = 0, startIndex = 0, length = null):  # Collection
	if startIndex < self.length:
		if length == null:
			length = self.length

		while length:
			self._collection[startIndex] = value
			startIndex += 1
			length -= 1

	return self


# @param  AbstractCallback  callback
func map(callback):  # Collection
	for key in self:
		self._collection[key] = callback.call([self._collection[key], key, self._collection])

	self.first()
	return self


# @param  AbstractCallback|null  callback
func filter(callback = null):  # Collection
	var new_collection = self.get_script().new(self.getCollection().duplicate())

	var i = 0
	if callback:
		var call

		while i < new_collection.length:
			var key = new_collection.getKeys()[i]
			var value = new_collection.get(key)

			call = callback.call([key, value, i, new_collection])

			if !call:
				new_collection.removeByIndex(i)
			else:
				i += 1
	else:
		while i < new_collection.length:
			var value = new_collection.getByIndex(i)
			if value == null or typeof(value) == TYPE_NIL or len(value) == 0:
				new_collection.removeByIndex(i)
			else:
				i += 1

	return new_collection


# Sets the internal iterator to the first element in the collection and returns this element.
func first():  # Variant|null
	if self.length:
		self._iterationCurrent = 0
		return self.getByIndex(self._iterationCurrent)

	return null


# Sets the internal iterator to the last element in the collection and returns this element.
func last(): # Variant|null
	if self.length:
		self._iterationCurrent = self.length - 1
		return self.getByIndex(self._iterationCurrent)

	return null


# Gets the current key/index at the current internal iterator position.
func key():  # Variant|null
	if self.length:
		return self._iter_get()

	return null


# Moves the internal iterator position to the next element and returns this element.
func next():  # Variant|null
	if self.length and self._iterationCurrent < self.length - 1:
		self._iterationCurrent += 1
		return self.getByIndex(self._iterationCurrent)

	return null


# Moves the internal iterator position to the previous element and returns this element.
func previous():  # Variant|null
	if self.length and self._iterationCurrent > 0:
		self._iterationCurrent -= 1
		return self.getByIndex(self._iterationCurrent)

	return null


# Gets the element of the collection at the current internal iterator position.
func current():  # Variant|null
	if self.length:
		return self._collection[self._iter_get()]

	return null


func getCollection():  # Variant
	return self._collection


func length():  # int
	return self._collection.size()


func size():  # int
	return self._collection.size()


# @override  _iter_init(?)
func _iter_init(arg):  # bool
	self._iterationCurrent = 0
	return self._iterationCurrent < self.length


# @override  _iter_next(?)
func _iter_next(arg):  # bool
	self._iterationCurrent += 1
	return self._iterationCurrent < self.length


# @override  _iter_get(?)
func _iter_get(arg = null):  # Variant
	return self._collection.keys()[self._iterationCurrent]


func getValueIterator():  # Iterator
	return Iterator.new(self, 'getByIndex')


func _setProtected(value):  # void
	print('QC/ArrayUtils/Collection: Attempted to set protected value, ignoring.')
