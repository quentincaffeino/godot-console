
extends Object


enum TYPE {
	VARIABLE,
	METHOD
}


# @var  string
var _alias

# @var  int
var _type

# Actual method or variable name
# @var  string
var _name

# @var  string
var _description = null

# @var  Array<Argument>
var _arguments = []

# @var  Variant
var _target


# @param  string  alias
func has(alias):  # bool
	pass


# @param  Array  args
func run(args):  # int
	pass


func describe():  # void
	pass


func requireArgs():  # int
	pass


func requireStrings():  # bool
	pass
