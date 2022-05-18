
extends 'res://addons/quentincaffeino/console/src/Type/BaseRegexCheckedType.gd'


func _init():
	super('Float', '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$')


# @param    Variant  value
# @returns  float
func normalize(value):
	return float(self._reextract(value).replace(',', '.'))
