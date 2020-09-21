
# @var  InputMap
var _input_map

# @var  Dictionary
var _actions = {}


# @param  InputMap    input_map
# @param  Dictionary  actions
func _init(input_map, actions = {}):
	self._input_map = input_map

	for action_name in actions:
		self.register_action(action_name, actions[action_name])


# @returns  InputMap
func get_input_map():
	return self._input_map


# @param    String      original_action_name
# @param    Dictionary  action
# @returns  void
func register_action(original_action_name, action):
	var action_name = action["name"]

	if not self._input_map.has_action(action_name):
		self._input_map.add_action(action_name, action["deadzone"] if "deadzone" in action else 0.5)

	var events = action["events"]
	for event_map in events:
		var event = InputEventKey.new()
		event.scancode = event_map["scancode"]
		self._input_map.action_add_event(action_name, event)

	self._actions[original_action_name] = action


# @param    String  action_name
# @returns  String
func get_real_action_name(action_name):
	if action_name in self._actions:
		return self._actions[action_name]["name"]
