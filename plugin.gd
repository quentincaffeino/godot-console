tool
extends EditorPlugin


const ConsoleName = 'Console'
const ConsolePath = 'res://addons/console/src/Console.tscn'


func _enter_tree():
	self.add_autoload_singleton(ConsoleName, ConsolePath)


func _exit_tree():
	self.remove_autoload_singleton(ConsoleName)
