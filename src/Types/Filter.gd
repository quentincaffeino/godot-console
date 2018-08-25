
extends 'BaseType.gd'


enum MODE {
  ALLOW,
  DENY
}


# @var  Variant[]
var _fliterList

# @var  int
var _mode


# @param  Variant[]  fliterList
# @param  int        mode
func _init(fliterList, mode = ALLOW):
  _name = 'Filter'
  _fliterList = fliterList
  _mode = mode


# @param  Variant  value
func check(value):  # int
  if (_mode == ALLOW and _fliterList.has(value)) or \
     (_mode == DENY and !_fliterList.has(value)):
    return OK

  return CANCELED
