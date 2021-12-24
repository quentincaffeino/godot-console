
extends "res://addons/gut/test.gd"

const ConsoleLine = preload("res://addons/quentincaffeino/console/src/ConsoleLine.gd")


func test_parse_command_simple_command_expect_ok():
	var command_name = "command"
	var command_line = "%s" % command_name

	var result = ConsoleLine._parse_command(command_line)

	assert_eq(result.command, command_line)
	assert_eq(result.name, command_name)


func test_parse_command_simple_command_with_simple_argument_expect_ok():
	var command_name = "command"
	var command_arg01 = "arg01"
	var command_line = "%s %s" % [command_name, command_arg01]

	var result = ConsoleLine._parse_command(command_line)

	assert_eq(result.command, command_line)
	assert_eq(result.name, command_name)
	assert_true(result.arguments.size() == 1)
	assert_eq(result.arguments[0], command_arg01)


func test_parse_commands_simple_commands_get_separated_expect_ok():
	var command_name01 = "command01"
	var command_name02 = "command02"
	var command_line = "%s;%s" % [command_name01, command_name02]

	var result = ConsoleLine._parse_commands(command_line)

	assert_true(result.size() == 2)
	assert_eq(result[0].name, command_name01)
	assert_eq(result[1].name, command_name02)
