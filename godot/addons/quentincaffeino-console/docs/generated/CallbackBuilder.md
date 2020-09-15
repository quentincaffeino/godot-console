<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# CallbackBuilder

**Extends:** [Reference](../Reference)

## Description

## Enumerations

### errors

```gdscript
const errors: Dictionary = {"qc.callback.call.ensure_failed":"QC/Callback: call: Failed to call a callback, ensuring failed. (%s, %s)","qc.callback.call.unknown_type":"QC/Callback: call: Unable to call unknown type. (%s, %s)","qc.callback.canCreate.first_arg":"QC/Callback: canCreate: First argument must be target object. Provided: %s.","qc.callback.canCreate.second_arg":"QC/Callback: canCreate: Second argument must be variable or method name (string). Provided: %s.","qc.callback.ensure.target_destroyed":"QC/Callback: ensure: Failed to call a callback, target was previously destroyed. (%s)","qc.callback.target_missing_mv":"QC/Callback: ensure: Target is missing method/variable. (%s, %s)"}
```

## Method Descriptions

### \_init

```gdscript
func _init(target: Reference)
```

### setName

```gdscript
func setName(name: String): CallbackBuilder
```

### getName

```gdscript
func getName(): String
```

### setType

```gdscript
func setType(type: int): CallbackBuilder
```

### getType

```gdscript
func getType(): int
```

### build

```gdscript
func build(): Callback|null
```

