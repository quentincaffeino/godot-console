
extends Node


func _ready():
	Console.register('set_label_text', {
		'description': 'The text of example label',
		'args': [['text', TYPE_STRING]],
		'target': [$ExampleLabel, 'text']
	})

	Console.register('change_label_text', {
		'description': 'Set the text of example label if condition is true',
		'args': [['condition', TYPE_BOOL], TYPE_STRING],
		'target': self
	})

	Console.register('pb_value', {
		'description': 'The level of progress bar',
		'args': [['value', Console.IntRange.new(0, 75, 6)]],
		'target': [$ProgressBar, 'value']
	})

	Console.register('cb_checked', {
		'description': 'The value of check box',
		'args': [TYPE_BOOL],
		'target': [$CheckBox, 'pressed']
	})

	Console.register('play_anim', {
		'description': 'Start playing animation on test scene with specific speed',
		'args': [['speed', TYPE_REAL]],
		'target': self
	})

	Console.register('filter_method', {
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


func _exit_tree():
	Console.unregister('set_label_text')
	Console.unregister('change_label_text')
	Console.unregister('pb_value')
	Console.unregister('cb_checked')
	Console.unregister('play_anim')
	Console.unregister('filter_method')
