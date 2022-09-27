tool
extends SceneTree
# Finds and generates a code RefCounted from gdscript files.


# Returns a list of file paths found in the directory.
#
# **Arguments**
#
# - dirpath: path to the directory from which to search files.
# - patterns: an array of string match patterns, where "*" matches zero or more
#   arbitrary characters and "?" matches any single character except a period
#   ("."). You can use it to find files by extensions. To find only GDScript
#   files, ["*.gd"]
# - is_recursive: if `true`, walks over subdirectories recursively, returning all
#   files in the tree.
func find_files(
	dirpath := "", patterns := PoolStringArray(), is_recursive := false, do_skip_hidden := true
) -> PoolStringArray:
	var file_paths := PoolStringArray()
	var directory := Directory.new()

	if not directory.dir_exists(dirpath):
		printerr("The directory does not exist: %s" % dirpath)
		return file_paths
	if not directory.open(dirpath) == OK:
		printerr("Could not open the following dirpath: %s" % dirpath)
		return file_paths

	directory.list_dir_begin(true, do_skip_hidden)
	var file_name := directory.get_next()
	var subdirectories := PoolStringArray()
	while file_name != "":
		if directory.current_is_dir() and is_recursive:
			var subdirectory := dirpath.plus_file(file_name)
			file_paths.append_array(find_files(subdirectory, patterns, is_recursive))
		else:
			for pattern in patterns:
				if file_name.match(pattern):
					file_paths.append(dirpath.plus_file(file_name))
		file_name = directory.get_next()

	directory.list_dir_end()
	return file_paths


# Saves text to a file.
func save_text(path := "", content := "") -> void:
	var dirpath := path.get_base_dir()
	var basename := path.get_file()
	if not dirpath:
		printerr("Couldn't save: the path %s is invalid." % path)
		return
	if not basename.is_valid_filename():
		printerr("Couldn't save: the file name, %s, contains invalid characters." % basename)
		return

	var directory := Directory.new()
	if not directory.dir_exists(dirpath):
		directory.make_dir(dirpath)

	var file := File.new()

	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()
	print("Saved data to %s" % path)


var middlewares = [
	funcref(self, "filter_out_init_files"),
	funcref(self, "fulfill_class_name"),
	funcref(self, "fix_missing_extends_class"),
	funcref(self, "fix_missing_with_docblocks"),
]

# Parses a list of GDScript files and returns a list of dictionaries with the
# code RefCounted data.
#
# If `refresh_cache` is true, will refresh Godot's cache and get fresh symbols.
func get_RefCounted(files := PoolStringArray(), refresh_cache := false) -> Dictionary:
	var data := {
		name = ProjectSettings.get_setting("application/config/name"),
		description = ProjectSettings.get_setting("application/config/description"),
		version = ProjectSettings.get_setting("application/config/version"),
		classes = []
	}

	var workspace = Engine.get_singleton('GDScriptLanguageProtocol').get_workspace()
	for file in files:
		if not file.ends_with(".gd"):
			continue

		if refresh_cache:
			workspace.parse_local_script(file)

		var symbols: Dictionary = workspace.generate_script_api(file)

		for middleware in self.middlewares:
			if middleware.call_funcv([symbols]):
				data["classes"].append(symbols)
			else:
				break

	return data


func print_pretty_json(RefCounted: Dictionary) -> String:
	return JSON.print(RefCounted, "  ")


func filter_out_init_files(symbols: Dictionary) -> bool:
	if not 'signature' in symbols:
		return true

	return !('__init__' in symbols['signature'])

func fulfill_class_name(symbols: Dictionary) -> bool:
	if 'name' in symbols and not len(symbols['name']):
		var regex = RegEx.new()
		regex.compile("^class\\ (.*)\\.gd$")
		var result = regex.search(symbols['signature'])
		if result:
			symbols['name'] = result.get_string(1)

	return true

func fix_missing_extends_class(symbols: Dictionary) -> bool:
	if 'extends_class' in symbols and not len(symbols['extends_class']):
		if len(symbols['extends_file']):
			var regex = RegEx.new()
			regex.compile("(\\w*)\\.gd$")
			var result = regex.search(symbols['extends_file'])
			if result:
				symbols['extends_class'].append(result.get_string(1))
		else:
			symbols['extends_class'].append("RefCounted")

	return true


func fix_missing_with_docblocks(symbols: Dictionary) -> bool:
	if 'members' in symbols:
		for member in symbols['members']:
			fix_missing_with_docblocks_on_element(member)
			rebuild_member_signature(member)

	if 'methods' in symbols:
		for method in symbols['methods']:
			fix_missing_with_docblocks_on_element(method)
			rebuild_method_signature(method)

	if 'static_functions' in symbols:
		for static_function in symbols['static_functions']:
			fix_missing_with_docblocks_on_element(static_function)
			rebuild_method_signature(static_function)

	return true

func fix_missing_with_docblocks_on_element(element: Dictionary) -> void:
	var docblocks_result = extract_docblock_lines(element)

	print(docblocks_result)

	element['is_deprecated'] = 'deprecated' in docblocks_result

	if 'var' in docblocks_result and len(docblocks_result['var']) and 'data_type' in element:
		var variables = docblocks_result['var']
		element['data_type'] = variables[len(variables) - 1]['type']

	if 'param' in docblocks_result and len(docblocks_result['param']) and 'arguments' in element:
		var variables = docblocks_result['param']
		for variable in variables:
			if 'property' in variable:
				var argument = get_element_by_name(element['arguments'], variable['property'])
				if argument:
					argument['type'] = variable['type']

	if 'returns' in docblocks_result and len(docblocks_result['returns']) and 'return_type' in element:
		var variables = docblocks_result['returns']
		element['return_type'] = variables[len(variables) - 1]['type']

func get_element_by_name(elements: Array, name: String):
	for element in elements:
		if 'name' in element and element['name'] == name:
			return element

	return null

func extract_docblock_lines(element: Dictionary) -> Dictionary:
	var description: String = element['description']
	var docblocks_result := {}
	var lines: PoolStringArray = description.split("\n")

	var docblock_line_regex := RegEx.new()
	docblock_line_regex.compile("\\@(?<tag>\\w*)\\ *(?<type>[\\w\\|\\[\\]\\<\\>\\/]*)\\ *(?<property>\\w*)")

	var lines_without_docblocs: PoolStringArray = []

	for line in lines:
		line = line.trim_prefix(" ").trim_suffix(" ")
		var result = docblock_line_regex.search(line)
		if result:
			var tag: String = result.get_string("tag")
			var type = result.get_string("type")
			var property = result.get_string("property")

			if type:
				if not tag in docblocks_result:
					docblocks_result[tag] = []

				var docblock_result := {
					"tag": tag,
					"type": type,
				}

				if property:
					docblock_result['property'] = property

				docblocks_result[tag].append(docblock_result)
			else:
				docblocks_result[tag] = true
		else:
			lines_without_docblocs.append(line)

	if len(lines_without_docblocs):
		element['description'] = lines_without_docblocs.join('\n')

	return docblocks_result

func rebuild_member_signature(member: Dictionary) -> void:
	member['signature'] = 'var ' + rebuild_argument_signature(member)

func rebuild_method_signature(method: Dictionary) -> void:
	method['signature'] = 'func %s(' % method['name']
	if 'arguments' in method:
		var arguments: PoolStringArray = []
		for argument in method['arguments']:
			arguments.append(rebuild_argument_signature(argument))
		method['signature'] += arguments.join(', ')

	method['signature'] += ')'

	if 'return_type' in method and method['return_type'] != 'var':
		method['signature'] += ': ' + method['return_type']

func rebuild_argument_signature(element: Dictionary) -> String:
	var argument = element['name']
	var type

	if 'data_type' in element:
		type = element['data_type']
	elif 'type' in element:
		type = element['type']

	if type != 'var':
		argument += ': ' + type

	return argument
