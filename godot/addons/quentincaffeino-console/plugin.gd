tool
extends EditorPlugin


const PluginName = 'Console'
const PluginPath = 'res://addons/quentincaffeino-console/src/Console.tscn'


func _enter_tree():
	self.add_autoload_singleton(PluginName, PluginPath)


func _exit_tree():
	self.remove_autoload_singleton(PluginName)
