<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Logger

**Extends:** [Reference](../Reference)

## Description

## Enumerations

### TYPE

```gdscript
const TYPE: Dictionary = {"DEBUG":0,"ERROR":3,"INFO":1,"NONE":4,"WARNING":2}
```

## Property Descriptions

### logLevel

```gdscript
var logLevel: int
```

## Method Descriptions

### ~~setLogLevel~~ <small>(deprecated)</small>

```gdscript
func setLogLevel(in_log_level: int): Log
```

### set\_log\_level

```gdscript
func set_log_level(in_log_level: int): Log
```

### log

```gdscript
func log(message: String, type: int): Log
```

Example usage:
```gdscript
Console.Log.log("Hello world!", Console.Log.TYPE.INFO)
```

### debug

```gdscript
func debug(message: String): Log
```

### info

```gdscript
func info(message: String): Log
```

### warn

```gdscript
func warn(message: String): Log
```

### error

```gdscript
func error(message: String): Log
```

