<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# CommandBuilder

**Extends:** [Reference](../Reference)

## Description

## Method Descriptions

### addArgument

```gdscript
func addArgument(name, type = null, description = null)
```

@param  string         name
@param  BaseType|null  type
@param  string|null    description
CommandBuilder

### setDescription

```gdscript
func setDescription(description = null)
```

@param  string|null  description
CommandBuilder

### register

```gdscript
func register()
```

void

### buildDeprecated <small>(static)</small>

```gdscript
func buildDeprecated(name, parameters)
```

@deprecated
@var  string     name
@var  Variant[]  parameters
Command|int