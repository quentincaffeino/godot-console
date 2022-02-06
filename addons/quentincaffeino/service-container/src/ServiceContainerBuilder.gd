
extends Reference

const ServiceContainer = preload("./ServiceContainer.gd")


# @var  { set: (key: String, value: Reference) => void, get: (key: String) => Reference|null }|Dictionary
var _store


# @param  { set: (key: String, value: Reference) => void, get: (key: String) => Reference|null }|Dictionary|null  [store]
func _init(store = null):
	self._store = store if store else {}


# @param    String            name
# @param    ContainedService  container_service
# @returns  ServiceContainerBuilder
func _set(name, container_service):
	if typeof(self._store) == TYPE_DICTIONARY:
		self._store[name] = container_service
	else:
		self._store.set(name, container_service)
	return self

# @param    string                               name
# @param    Resource<string|Resource|Reference>  service
# @param    Dictionary                           [props]
# @returns  ServiceContainerBuilder
func set(name, service, props = {}):
	var container_service = ServiceContainer.ContainedService.new(service, props)
	self._set(name, container_service)
	return self

# @param    Resource<string|Resource|Reference>  service
# @param    Dictionary                           [props]
# @returns  ServiceContainerBuilder
func add(service, props = {}):
	var container_service = ServiceContainer.ContainedService.new(service, props)
	self._set(container_service.get_name(), container_service)
	return self


# @returns  ServiceContainer
func build():
	return ServiceContainer.new(self._store)
