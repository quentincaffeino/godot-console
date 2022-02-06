
extends Reference

const Optional = preload("res://addons/quentincaffeino/common/src/Optional.gd")


# @var  { set: (key: String, value: Reference) => void, get: (key: String) => Reference|null }|Dictionary
var _store


# @param  { set: (key: String, value: Reference) => void, get: (key: String) => Reference|null }|Dictionary  store
func _init(store):
	self._store = store


# @param    String            name
# @param    ContainedService  container_service
# @returns  ServiceContainer
func _set(name, container_service):
	if typeof(self._store) == TYPE_DICTIONARY:
		self._store[name] = container_service
	else:
		self._store.set(name, container_service)
	return self

# @param    String                     name
# @param    String|Resource|Reference  service
# @param    Dictionary  [props]
# @returns  ServiceContainer
func set(name, service, props = {}):
	var container_service = ContainedService.new(service, props)
	self._set(name, container_service)
	return self

# @param    String|Resource|Reference  service
# @param    Dictionary                 [props]
# @returns  ServiceContainer
func add(service, props = {}):
	var container_service = ContainedService.new(service, props)
	self._set(container_service.get_name(), container_service)
	return self

# @param    String  name
# @returns  Optional<Service>
func get(name):
	var service = self._store.get(name)
	assert(service, "missing service `%s`" % name)
	return Optional.new(service.get_instance(self) if service else null)


class ContainedService:

	# @var  String
	var _name

	# @var  String
	var _path

	# @var  Resource
	var _resource

	# @var  Reference
	var _instance

	# @var  bool
	var _is_factory


	# @param  String|Resource|Reference  service
	# @param  Dictionary                 [props]
	func _init(service, props = {}):
		if typeof(service) == TYPE_STRING:
			self._path = service
		elif service is Resource:
			self._resource = service
		else:
			self._instance = service

		self._is_factory = props["factory"] if "factory" in props else false


	# @returns  String
	func get_name():
		if self._path:
			self._name = self._path.rsplit(".", true, 1)[0]
		elif self._resource:
			self._name = self._resource.resource_path.rsplit(".", true, 1)[0]
		else:
			assert(self._instance.has_method("get_name"), "service is missing `get_name` method")
			self._name = self._instance.get_name()

		return self._name

	# @param    ServiceContainer  container
	# @returns  Reference
	func get_instance(container):
		if not self._instance:
			if self._path:
				self._resource = load(self._path)

			if self._resource:
				if self._is_factory:
					self._instance = self._resource.create(container)
				else:
					self._instance = self._resource.new(container)

		return self._instance
