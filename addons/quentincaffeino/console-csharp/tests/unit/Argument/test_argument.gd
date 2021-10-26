
extends "res://addons/gut/test.gd"

const Argument = preload("res://addons/quentincaffeino/console/src/Argument/Argument.gd")
const ArgumentFactory = preload("res://addons/quentincaffeino/console/src/Argument/ArgumentFactory.gd")


# @var  string
var argumentName = 'test-arg'

# @var  Argument
var argument

func before_each():
	self.argument = ArgumentFactory.create(argumentName).get_value()


func test_set_value():
	var test_value = "test value"
	self.argument.set_value(test_value)
	assert_eq(test_value, self.argument.get_value())


func test_set_value_check_ok():
	var test_value = "test value"
	assert_eq(Argument.ASSIGNMENT.OK, self.argument.set_value(test_value))


func test_get_normalized_value():
	var test_value = "test value"
	self.argument.set_value(test_value)
	assert_eq(test_value, self.argument.get_normalized_value())


func test_describe():
	assert_eq("<" + self.argumentName + ":Any>", self.argument.describe())
