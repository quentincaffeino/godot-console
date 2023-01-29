
extends "res://addons/quentincaffeino/array-utils/src/Collection.gd"

const CallbackBuilderFactory = preload("res://addons/@quentincaffeino/godot-callback/src/CallbackBuilderFactory.gd")


# @var  Callback
var _filter_fn_cb


# @param  Variant  collection
func _init(collection = {}).(collection):
	self._filter_fn_cb = CallbackBuilderFactory.get_callback_builder(self)\
		.set_name("_find_match")\
		.build()

# @param    String  command_name
# @returns  CommandCollection
func find(command_name):
	var cb = self._filter_fn_cb.bind([command_name])
	return self.filter(cb)

# @param    String      match_key
# @param    String      key
# @param    String      _value
# @param    int         _i
# @param    Collection  _collection
# @returns  bool
func _find_match(match_key, key, _value, _i, _collection):
	return key.begins_with(match_key)
