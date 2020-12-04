<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Console

**Extends:** [CanvasLayer](../CanvasLayer)

## Description

## Constants Descriptions

### BaseCommands

```gdscript
const BaseCommands: GDScript = preload("res://addons/quentincaffeino-console/src/Misc/BaseCommands.gd")
```

### CommandService

```gdscript
const CommandService: GDScript = preload("res://addons/quentincaffeino-console/src/Command/CommandService.gd")
```

### DefaultActionServiceFactory

```gdscript
const DefaultActionServiceFactory: GDScript = preload("res://addons/quentincaffeino-console/src/Misc/DefaultActionServiceFactory.gd")
```

### DefaultActions

```gdscript
const DefaultActions: GDScript = preload("res://addons/quentincaffeino-console/src/Misc/DefaultActions.gd")
```

### FilterType

```gdscript
const FilterType: GDScript = preload("res://addons/quentincaffeino-console/src/Type/FilterType.gd")
```

### FloatRangeType

```gdscript
const FloatRangeType: GDScript = preload("res://addons/quentincaffeino-console/src/Type/FloatRangeType.gd")
```

### IntRangeType

```gdscript
const IntRangeType: GDScript = preload("res://addons/quentincaffeino-console/src/Type/IntRangeType.gd")
```

## Custom console types

## Property Descriptions

### History

```gdscript
var History: History
```

### Log

```gdscript
var Log: Logger
```

### is\_console\_shown

```gdscript
var is_console_shown: bool
```

### consume\_input

```gdscript
var consume_input: bool
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

### get\_action\_service

```gdscript
func get_action_service(): Misc/ActionService
```

### ~~getCommand~~ <small>(deprecated)</small>

```gdscript
func getCommand(name: String): Command/Command|null
```

### get\_command

```gdscript
func get_command(name: String): Command/Command|null
```

### ~~findCommands~~ <small>(deprecated)</small>

```gdscript
func findCommands(name: String): Command/CommandCollection
```

### find\_commands

```gdscript
func find_commands(name: String): Command/CommandCollection
```

### ~~addCommand~~ <small>(deprecated)</small>

```gdscript
func addCommand(name: String, target: Reference, target_name: String|null): Command/CommandBuilder
```

### add\_command

```gdscript
func add_command(name: String, target: Reference, target_name: String|null): Command/CommandBuilder
```

Example usage:
```gdscript
Console.add_command('sayHello', self, 'print_hello')\
	.set_description('Prints "Hello %name%!"')\
	.add_argument('name', TYPE_STRING)\
	.register()
```

### ~~removeCommand~~ <small>(deprecated)</small>

```gdscript
func removeCommand(name: String): int
```

### remove\_command

```gdscript
func remove_command(name: String): int
```

### write

```gdscript
func write(message: String): void
```

### ~~writeLine~~ <small>(deprecated)</small>

```gdscript
func writeLine(message: String): void
```

### write\_line

```gdscript
func write_line(message: String): void
```

### clear

```gdscript
func clear(): void
```

### toggleConsole

```gdscript
func toggleConsole(): Console
```

### toggle\_console

```gdscript
func toggle_console(): Console
```

## Signals

- signal toggled(is_console_shown: bool)
- signal command_added(name: String, target: Reference, target_name: String|null)
- signal command_removed(name: String)
- signal command_executed(command: Command)
- signal command_not_found(name: String)
