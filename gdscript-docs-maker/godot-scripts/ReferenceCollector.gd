tool
extends EditorScript
class_name RefCountedCollector
# Finds and generates a code RefCounted from gdscript files.
#
# To use this tool:
#
# - Place this script and Collector.gd in your Godot project folder.
# - Open the script in the script editor.
# - Modify the properties below to control the tool's behavior.
# - Go to File -> Run to run the script in the editor.


var Collector: SceneTree = load("Collector.gd").new()
# A list of directories to collect files from.
var directories := ["res://src"]
# If true, explore each directory recursively
var is_recursive: = true
# A list of patterns to filter files.
var patterns := ["*.gd"]
# Output path to save the class RefCounted.
var save_path := "res://RefCounted.json"


func _run() -> void:
	var files := PoolStringArray()
	for dirpath in directories:
		files.append_array(Collector.find_files(dirpath, patterns, is_recursive))
	var json: String = Collector.print_pretty_json(Collector.get_RefCounted(files))
	Collector.save_text(save_path, json)
