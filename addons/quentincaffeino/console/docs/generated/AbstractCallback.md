<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# AbstractCallback

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
func _init(target: Reference, type)
```

### getTarget

```gdscript
func getTarget()
```

Reference

### getType

```gdscript
func getType()
```

Utils.Type

### ensure

```gdscript
func ensure()
```

Ensure callback target exists
boolean

### bind

```gdscript
func bind(argv: Variant[])
```

void

### call

```gdscript
func call(argv: Variant[])
```

Variant