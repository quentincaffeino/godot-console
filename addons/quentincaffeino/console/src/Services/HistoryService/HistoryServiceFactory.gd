
extends Reference

const HistoryService = preload("./HistoryService.gd")


static func create(container):
	var console_optional = container.get("console")
	if console_optional.is_present():
		return HistoryService.new(console_optional.get_value())
