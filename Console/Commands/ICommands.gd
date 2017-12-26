
extends Object


# @var  CommandAutocomplete
var Autocomplete = preload('CommandAutocomplete.gd').new() setget _setProtected

# @var  Dictionary
var _commands = {}


# @param  string  alias
# @param  Dictionary  params
func register(alias, params):  # int
	pass


# @param  string  alias
func deregister(alias):  # void
	pass


# @param  string  alias
func get(alias):  # Command
	pass


# @param  string  alias
func has(alias):  # bool
	pass


func printAll():  # void
	pass


func _setProtected(value):  # void
	pass
