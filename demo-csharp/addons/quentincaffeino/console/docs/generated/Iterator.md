<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Iterator

**Extends:** [Reference](../Reference)

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
func _init(target: Reference, getValueField: string, getLengthField: string)
```

### length

```gdscript
func length()
```

int

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