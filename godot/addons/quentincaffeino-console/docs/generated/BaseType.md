<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# BaseType

**Extends:** [Reference](../Reference)

## Description

## Enumerations

### CHECK

```gdscript
const CHECK: Dictionary = {"CANCELED":2,"FAILED":1,"OK":0}
```

## Method Descriptions

### \_init

```gdscript
func _init(name: String)
```

### check

```gdscript
func check(value: Variant): int
```

Assignment check.
Returns one of the statuses:
CHECK.OK, CHECK.FAILED and CHECK.CANCELED

### normalize

```gdscript
func normalize(value: Variant): Variant
```

Normalize variable

### ~~toString~~ <small>(deprecated)</small>

```gdscript
func toString(): String
```

### to\_string

```gdscript
func to_string(): String
```

