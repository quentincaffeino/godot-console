
const ActionService = preload('./ActionService.gd')
const DefaultActions = preload('./DefaultActions.gd')


# @returns  ActionService
static func create():
	return ActionService.new(InputMap, DefaultActions.actions)
