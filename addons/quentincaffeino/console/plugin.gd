@tool
extends EditorPlugin

const DefaultActions = preload("./DefaultActions.gd")


const PLUGIN_NAME = 'Console'
const PLUGIN_PATH = 'res://addons/quentincaffeino/console/src/Console.tscn'


func _enter_tree():
	self.add_autoload_singleton(PLUGIN_NAME, PLUGIN_PATH)
	DefaultActions.register()


func _exit_tree():
	self.remove_autoload_singleton(PLUGIN_NAME)
