
extends "res://addons/gut/test.gd"

const Argument = preload("res://addons/quentincaffeino-console/src/Argument/Argument.gd")
const ArgumentFactory = preload("res://addons/quentincaffeino-console/src/Argument/ArgumentFactory.gd")


# @var  string
var argumentName = 'test-arg'

# @var  Argument
var argument

func before_each():
	self.argument = ArgumentFactory.create(argumentName)


func test_set_value():
	var test_value = "test value"
	self.argument.setValue(test_value)
	assert_eq(test_value, self.argument.getValue())


func test_set_value_check_ok():
	var test_value = "test value"
	assert_eq(Argument.ASSIGNMENT.OK, self.argument.setValue(test_value))


func test_get_normalized_value():
	var test_value = "test value"
	self.argument.setValue(test_value)
	assert_eq(test_value, self.argument.getNormalizedValue())


func test_describe():
	assert_eq(self.argumentName + ":Any", self.argument.describe())
