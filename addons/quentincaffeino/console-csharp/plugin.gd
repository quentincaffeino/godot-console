@tool
extends EditorPlugin

const DefaultActions = preload("../console/DefaultActions.gd")


const PLUGIN_NAME = 'Console'
const PLUGIN_PATH = 'res://addons/quentincaffeino/console/src/Console.tscn'
const CSHARP_PLUGIN_NAME = 'CSharpConsole'
const CSHARP_PLUGIN_PATH = "res://addons/quentincaffeino/console-csharp/src/Console.cs"


func _enter_tree():
	self.add_autoload_singleton(PLUGIN_NAME, PLUGIN_PATH)
	self.add_autoload_singleton(CSHARP_PLUGIN_NAME, CSHARP_PLUGIN_PATH)
	DefaultActions.register()


func _exit_tree():
	self.remove_autoload_singleton(PLUGIN_NAME)
	self.remove_autoload_singleton(CSHARP_PLUGIN_NAME)
