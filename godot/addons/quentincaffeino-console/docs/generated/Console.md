<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Console

**Extends:** [CanvasLayer](../CanvasLayer)

## Description

## Property Descriptions

### History

```gdscript
var History: History
```

### Log

```gdscript
var Log: Logger
```

### isConsoleShown

```gdscript
var isConsoleShown: bool
```

### consumeInput

```gdscript
var consumeInput: bool
```

### action\_console\_toggle

```gdscript
var action_console_toggle: String
```

### action\_history\_up

```gdscript
var action_history_up: String
```

### action\_history\_down

```gdscript
var action_history_down: String
```

### Text

```gdscript
var Text
```

### Line

```gdscript
var Line
```

## Method Descriptions

### get\_command\_service

```gdscript
func get_command_service(): Command/CommandService
```

### getCommand

```gdscript
func getCommand(name: String): Command/Command|null
```

### findCommands

```gdscript
func findCommands(name: String): Command/CommandCollection
```

### addCommand

```gdscript
func addCommand(name: String, target: Reference, target_name: String|null): Command/CommandBuilder
```

### removeCommand

```gdscript
func removeCommand(name: String): int
```

### write

```gdscript
func write(message: String): void
```

### writeLine

```gdscript
func writeLine(message: String): void
```

### clear

```gdscript
func clear(): void
```

### toggleConsole

```gdscript
func toggleConsole(): void
```

