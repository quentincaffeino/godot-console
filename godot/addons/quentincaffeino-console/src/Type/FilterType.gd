
extends 'res://addons/quentincaffeino-console/src/Type/BaseType.gd'


enum MODE \
{
	ALLOW,
	DENY
}


# @var  Array
var _filterList

# @var  int
var _mode


# @param  Array  filterList
# @param  int    mode
func _init(filterList, mode = MODE.ALLOW).('Filter'):
	self._filterList = filterList
	self._mode = mode


# @param    Variant  value
# @returns  int
func check(value):
	if (self._mode == MODE.ALLOW and self._filterList.has(value)) or \
		(self._mode == MODE.DENY and !self._filterList.has(value)):
		return CHECK.OK

	return CHECK.CANCELED
