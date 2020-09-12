
extends 'res://addons/quentincaffeino-console/src/Type/BaseRegexCheckedType.gd'


func _init().('Int', '^[+-]?\\d+$'):
	pass


# @param  Varian  _value
func normalize(_value):  # int
	return int(self._reextract(_value))
