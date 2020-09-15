
extends 'res://addons/quentincaffeino-console/addons/quentincaffeino-array-utils/src/Collection.gd'

const CallbackBuilder = preload('res://addons/quentincaffeino-console/addons/quentincaffeino-callback/src/CallbackBuilder.gd')


func _init(collection = {}).(collection):
	pass


# @param    String  command_name
# @returns  CommandCollection
func find(command_name):
	var filter_cb_fn = CallbackBuilder.new(self).setName('_find_match').build()
	filter_cb_fn.bind([command_name])
	return self.filter(filter_cb_fn)


# @param    String      match_key
# @param    String      key
# @param    String      value
# @param    int         _i
# @param    Collection  _collection
# @returns  bool
func _find_match(match_key, key, value, _i, _collection):
	return key.begins_with(match_key)
