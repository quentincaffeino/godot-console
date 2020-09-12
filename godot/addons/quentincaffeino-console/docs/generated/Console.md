<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Console

**Extends:** [CanvasLayer](../CanvasLayer)

## Description

## Property Descriptions

### History

```gdscript
var History
```

- **Setter**: `_setProtected`

@var  History

### Log

```gdscript
var Log
```

- **Setter**: `_setProtected`

@var  Logger

### isConsoleShown

```gdscript
var isConsoleShown
```

- **Setter**: `_setProtected`

@var  bool

### submitAutocomplete

```gdscript
var submitAutocomplete
```

@var  bool

### consumeInput

```gdscript
var consumeInput
```

@var bool

### action\_console\_toggle

```gdscript
export var action_console_toggle = "console_toggle"
```

@var  string

### action\_history\_up

```gdscript
export var action_history_up = "ui_up"
```

@var  string

### action\_history\_down

```gdscript
export var action_history_down = "ui_down"
```

@var  string

### Text

```gdscript
var Text
```

- **Setter**: `_setProtected`

### Line

```gdscript
var Line
```

- **Setter**: `_setProtected`

## Method Descriptions

### getCommand

```gdscript
func getCommand(name)
```

@param  string  name
Command/Command|null

### register

```gdscript
func register(name, parameters)
```

@param  string     name
@param  Variant[]  parameters
bool

### unregister

```gdscript
func unregister(name)
```

@param  string  name
int

### addCommand

```gdscript
func addCommand(name, target, targetName = null)
```

@param  string       name
@param  Reference    target
@param  string|null  targetName
CommandBuilder

### removeCommand

```gdscript
func removeCommand(name)
```

@param  string  name
int

### write

```gdscript
func write(message)
```

@param  string  message
void

### writeLine

```gdscript
func writeLine(message = "")
```

@param  string  message
void

### clear

```gdscript
func clear()
```

void

### toggleConsole

```gdscript
func toggleConsole()
```

void