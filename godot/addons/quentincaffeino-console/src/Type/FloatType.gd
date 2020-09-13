
extends 'res://addons/quentincaffeino-console/src/Type/BaseRegexCheckedType.gd'


func _init().('Float', '^[+-]?([0-9]*[\\.\\,]?[0-9]+|[0-9]+[\\.\\,]?[0-9]*)([eE][+-]?[0-9]+)?$'):
	pass


# @param    Variant  value
# @returns  float
func normalize(value):
	return float(self._reextract(value).replace(',', '.'))
