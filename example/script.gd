
extends Node


func _ready():

	Console.register('set_label_text', {
		'type': Console.VARIABLE,
		'name': 'text',
		'description': 'The text of example label',
		'arg': ['text', TYPE_STRING],
		'target': $ExampleLabel
	})

	Console.register('change_label_text', {
		'type': Console.METHOD,
		'description': 'Set the text of example label if condition is true',
		'args': [['condition', TYPE_BOOL], TYPE_STRING],
		'target': self
	})

	Console.register('pb_value', {
		'type': Console.VARIABLE,
		'name': 'value',
		'description': 'The level of progress bar',
		'arg': ['value', Console.IntRange.new(0, 75, 6)],
		'target': $ProgressBar
	})

	Console.register('cb_checked', {
		'type': Console.VARIABLE,
		'name': 'pressed',
		'description': 'The value of check box',
		'arg': TYPE_BOOL,
		'target': $CheckBox
	})

	Console.register('play_anim', {
		'type': Console.METHOD,
		'description': 'Start playing animation on test scene with specific speed',
		'args': [['speed', TYPE_REAL]],
		'target': self
	})

	Console.register('filter_method', {
		'type': Console.METHOD,
		'description': 'Filter input',
		'args': [['filter', Console.Filter.new(['hello', 'world'])]],
		'target': self
	})


func change_label_text(cond, text):
	if cond:
		$ExampleLabel.text = text


func play_anim(speed):
	$AnimationPlayer.play('test')
	$AnimationPlayer.set_speed_scale(speed)


func filter_method(filtered):
	print(filtered)
