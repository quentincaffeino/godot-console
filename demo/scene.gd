extends Control


@onready var label = $VBoxContainer/Label


func _ready():
	Console.add_command("set_label_text", self, "_set_label_text")\
		.add_argument("text", TYPE_STRING)\
		.register()


func _set_label_text(new_text):
	label.text = new_text
