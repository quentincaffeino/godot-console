<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Collection

**Extends:** [Utils](../Utils) < [Reference](../Reference)

## Description

## Property Descriptions

### length

```gdscript
var length: int
```

- **Getter**: `length`

## Method Descriptions

### \_init

```gdscript
func _init(collection: Variant)
```

### replaceCollection

```gdscript
func replaceCollection(collection: Variant)
```

void

### set

```gdscript
func set(key: Variant, value: Variant)
```

Adds/sets an element in the collection at the index / with the specified key.
void

### add

```gdscript
func add(value: Variant)
```

Adds an element to the collection.
void

### remove

```gdscript
func remove(key: Variant)
```

Removes an element with a specific key/index from the collection.
void

### removeElement

```gdscript
func removeElement(element: Variant)
```

Removes the specified element from the collection, if it is found.
bool

### removeByIndex

```gdscript
func removeByIndex(index: int)
```

void

### containsKey

```gdscript
func containsKey(key)
```

Checks whether the collection contains a specific key/index.
bool

### contains

```gdscript
func contains(element: Variant)
```

Checks whether the given element is contained in the collection.
Only element values are compared, not keys. The comparison of
two elements is strict, that means not only the value but also
the type must match. For objects this means reference equality.
bool

### indexOf

```gdscript
func indexOf(element: Variant)
```

Searches for a given element and, if found, returns the corresponding
key/index of that element. The comparison of two elements is strict,
that means not only the value but also the type must match.
For objects this means reference equality.
Variant|null

### get

```gdscript
func get(key: Variant)
```

Gets the element with the given key/index.
Variant|null

### getByIndex

```gdscript
func getByIndex(index: int)
```

Variant|null

### getKeys

```gdscript
func getKeys()
```

Gets all keys/indexes of the collection elements.
Variant[]

### getValues

```gdscript
func getValues()
```

Gets all elements.
Variant[]

### isEmpty

```gdscript
func isEmpty()
```

Checks whether the collection is empty.
bool

### clear

```gdscript
func clear()
```

Clears the collection.
void

### slice

```gdscript
func slice(offset: int, length: int|null)
```

Extract a slice of `length` elements starting at
position `offset` from the Collection.
Collection

### fill

```gdscript
func fill(value: Variant, startIndex: int, length: int|null)
```

Fill an array with values.
Collection

### map

```gdscript
func map(callback: AbstractCallback)
```

Collection

### filter

```gdscript
func filter(callback: AbstractCallback|null)
```

Collection

### first

```gdscript
func first()
```

Sets the internal iterator to the first element in the collection and returns this element.
Variant|null

### last

```gdscript
func last()
```

Sets the internal iterator to the last element in the collection and returns this element.
Variant|null

### key

```gdscript
func key()
```

Gets the current key/index at the current internal iterator position.
Variant|null

### next

```gdscript
func next()
```

Moves the internal iterator position to the next element and returns this element.
Variant|null

### previous

```gdscript
func previous()
```

Moves the internal iterator position to the previous element and returns this element.
Variant|null

### current

```gdscript
func current()
```

Gets the element of the collection at the current internal iterator position.
Variant|null

### getCollection

```gdscript
func getCollection()
```

Variant

### length

```gdscript
func length()
```

int

### size

```gdscript
func size()
```

int

### getValueIterator

```gdscript
func getValueIterator()
```

Iterator