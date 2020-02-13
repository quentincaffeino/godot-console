
extends 'BaseType.gd'


enum MODE \
{
	ALLOW,
	DENY
}


# @var  Variant[]
var _fliterList

# @var  int
var _mode


# @param  Variant[]  fliterList
# @param  int        mode
func _init(fliterList, mode = MODE.ALLOW):
	_name = 'Filter'
	_fliterList = fliterList
	_mode = mode


# @param  Variant  value
func check(value):  # int
	if (_mode == MODE.ALLOW and _fliterList.has(value)) or \
		 (_mode == MODE.DENY and !_fliterList.has(value)):
		return CHECK.OK

	return CHECK.CANCELED
