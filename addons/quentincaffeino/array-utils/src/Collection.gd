
extends "Utils.gd"

const Iterator = preload("res://addons/quentincaffeino/iterator/src/Iterator.gd")


# @var  Dictionary
var _collection

# @var  int
var _iterationCurrent = 0

# @var  int
var length setget _set_readonly, length


# @param  Variant  collection
func _init(collection = {}):
	self.replace_collection(collection)


# @param    Variant  collection
# @returns  void
func replace_collection(collection):
	self._collection = self.to_dict(collection)


# Adds/sets an element in the collection at the index / with the specified key.
# @param    Variant  key
# @param    Variant  value
# @returns  void
func set(key, value):
	self._collection[key] = value


# Adds an element to the collection.
# @param    Variant  value
# @returns  void
func add(value):
	self.set(self.length, value)


# Removes an element with a specific key/index from the collection.
# @param    Variant  key
# @returns  void
func remove(key):
	self._collection.erase(key)


# Removes the specified element from the collection, if it is found.
# @param    Variant  element
# @returns  bool
func remove_element(element):
	for key in self._collection:
		if self._collection[key] == element:
			self._collection.erase(key)
			return true

	return false


# @param    int  index
# @returns  void
func remove_by_index(index):
	var keys = self._collection.keys()

	if index >= 0 and index < keys.size():
		self._collection.erase(keys[index])


# Checks whether the collection contains a specific key/index.
# @param    Variant  key
# @returns  bool
func contains_key(key):
	return self._collection.has(key)


# Checks whether the given element is contained in the collection.
# Only element values are compared, not keys. The comparison of
# two elements is strict, that means not only the value but also
# the type must match. For objects this means reference equality.
# @param    Variant  element
# @returns  bool
func contains(element):
	for key in self._collection:
		if self._collection[key] == element:
			return true

	return false


# Searches for a given element and, if found, returns the corresponding
# key/index of that element. The comparison of two elements is strict,
# that means not only the value but also the type must match.
# For objects this means reference equality.
# @param    Variant  element
# @returns  Variant|null
func index_of(element):
	for key in self._collection:
		if self._collection[key] == element:
			return key

	return null


# Gets the element with the given key/index.
# @param    Variant  key
# @returns  Variant|null
func get(key):
	if self.contains_key(key):
		return self._collection[key]

	return null


# @param    int  index
# @returns  Variant|null
func get_by_index(index):
	var keys = self._collection.keys()

	if index >= 0 and index < keys.size():
		return self._collection[keys[index]]

	return null


# Gets all keys/indexes of the collection elements.
# @returns  Variant[]
func get_keys():
	return self._collection.keys()


# Gets all elements.
# @returns  Variant[]
func get_values():
	return self._collection.values()


# Checks whether the collection is empty.
# @returns  bool
func is_empty():
	return self.length == 0


# Clears the collection.
# @returns  void
func clear():
	self._collection = {}


# Extract a slice of `length` elements starting at
# position `offset` from the Collection.
# @param    int       offset
# @param    int|null  length
# @returns  Collection
func slice(offset, length = null):
	var result = get_script().new()

	if offset < self.length:
		if length == null:
			length = self.length

		var i = 0
		while length and i < self.length:
			result.set( i, self.get_by_index(offset + i) )
			length -= 1
			i += 1

	return result


# Fill an array with values.
# @param    Variant   value
# @param    int       startIndex
# @param    int|null  length
# @returns  Collection
func fill(value = null, startIndex = 0, length = null):
	if startIndex < self.length:
		if length == null:
			length = self.length

		while length:
			self._collection[startIndex] = value
			startIndex += 1
			length -= 1

	return self


# @param    AbstractCallback  callback
# @returns  Collection
func map(callback):
	for key in self:
		self._collection[key] = callback.call([self._collection[key], key, self._collection])

	self.first()
	return self


# @param    AbstractCallback|null  callback
# @returns  Collection
func filter(callback = null):
	var new_collection = self.get_script().new(self.get_collection().duplicate())

	var i = 0
	if callback:
		var call

		while i < new_collection.length:
			var key = new_collection.get_keys()[i]
			var value = new_collection.get(key)

			call = callback.call([key, value, i, new_collection])

			if !call:
				new_collection.remove_by_index(i)
			else:
				i += 1
	else:
		while i < new_collection.length:
			var value = new_collection.get_by_index(i)
			if value == null or typeof(value) == TYPE_NIL or len(value) == 0:
				new_collection.remove_by_index(i)
			else:
				i += 1

	return new_collection


# Sets the internal iterator to the first element in the collection and returns this element.
# @returns  Variant|null
func first():
	if self.length:
		self._iterationCurrent = 0
		return self.get_by_index(self._iterationCurrent)

	return null


# Sets the internal iterator to the last element in the collection and returns this element.
# @returns  Variant|null
func last():
	if self.length:
		self._iterationCurrent = self.length - 1
		return self.get_by_index(self._iterationCurrent)

	return null


# Gets the current key/index at the current internal iterator position.
# @returns  Variant|null
func key():
	if self.length:
		return self._iter_get()

	return null


# Moves the internal iterator position to the next element and returns this element.
# @returns  Variant|null
func next():
	if self.length and self._iterationCurrent < self.length - 1:
		self._iterationCurrent += 1
		return self.get_by_index(self._iterationCurrent)

	return null


# Moves the internal iterator position to the previous element and returns this element.
# @returns  Variant|null
func previous():
	if self.length and self._iterationCurrent > 0:
		self._iterationCurrent -= 1
		return self.get_by_index(self._iterationCurrent)

	return null


# Gets the element of the collection at the current internal iterator position.
# @returns  Variant|null
func current():
	if self.length:
		return self._collection[self._iter_get()]

	return null


# @returns  Variant
func get_collection():
	return self._collection


# @returns  int
func length():
	return self._collection.size()


# @returns  int
func size():
	return self._collection.size()


# @override  _iter_init(?)
# @returns  bool
func _iter_init(arg):
	self._iterationCurrent = 0
	return self._iterationCurrent < self.length


# @override  _iter_next(?)
# @returns  bool
func _iter_next(arg):
	self._iterationCurrent += 1
	return self._iterationCurrent < self.length


# @override  _iter_get(?)
# @returns  Variant
func _iter_get(arg = null):
	return self._collection.keys()[self._iterationCurrent]


# @returns  Iterator
func get_value_iterator():
	return Iterator.new(self, "get_by_index")


# @returns  void
func _set_readonly(value):
	print("qc/array-utils: Collection: Attempted to set readonly value, ignoring.")
