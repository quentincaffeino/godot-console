<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# CommandService

**Extends:** [Reference](../Reference)

## Description

## Method Descriptions

### \_init

```gdscript
func _init(console: Console)
```

### values

```gdscript
func values(): Iterator
```

### create

```gdscript
func create(command_name: String, target: Reference, target_name: String|null): CommandBuilder
```

### set

```gdscript
func set(command_name: String, command: Command): bool
```

### get

```gdscript
func get(command_name: String): Command|null
```

### find

```gdscript
func find(command_name: String): CommandCollection
```

### remove

```gdscript
func remove(command_name: String): void
```

### autocomplete

```gdscript
func autocomplete(command_name: String): String
```

