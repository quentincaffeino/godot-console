<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# CommandGroup

**Extends:** [Reference](../Reference)

## Description

## Method Descriptions

### getName

```gdscript
func getName()
```

string

### getGroups

```gdscript
func getGroups()
```

ArrayCollection<string, CommandGroup>

### getCommands

```gdscript
func getCommands()
```

ArrayCollection<string, Command>

### registerCommand

```gdscript
func registerCommand(name, parameters)
```

@var  string     name
@var  Variant[]  parameters
bool

### unregisterCommand

```gdscript
func unregisterCommand(name)
```

### getCommand

```gdscript
func getCommand(name)
```

@var  string  name
Command|null

### printAll

```gdscript
func printAll()
```

void