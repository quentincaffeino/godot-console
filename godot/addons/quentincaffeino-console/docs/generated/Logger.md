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
var logLevel
```

- **Setter**: `setLogLevel`

@var  int

## Method Descriptions

### setLogLevel

```gdscript
func setLogLevel(inlogLevel)
```

@param  int  inlogLevel
Log

### log

```gdscript
func log(message, type)
```

@param  string  message
@param  int     type
Log

### debug

```gdscript
func debug(message)
```

@param  string  message
Log

### info

```gdscript
func info(message)
```

@param  string  message
Log

### warn

```gdscript
func warn(message)
```

@param  string  message
Log

### error

```gdscript
func error(message)
```

@param  string  message
Log