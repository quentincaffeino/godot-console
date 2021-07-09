
extends "res://addons/gut/test.gd"

const ArgumentFactory = preload("res://addons/quentincaffeino/console/src/Argument/ArgumentFactory.gd")
const Argument = preload("res://addons/quentincaffeino/console/src/Argument/Argument.gd")
const AnyType = preload("res://addons/quentincaffeino/console/src/Type/AnyType.gd")
const Error = preload("res://addons/quentincaffeino/console/src/Misc/Error.gd")


func test_create_with_type_of_type_non_base_type_expect_error():
	var result = ArgumentFactory.create("some-name", Reference.new())
	assert_is(result.get_error(), Error, "Expected to have error because argument factory only works with TYPE_INT and BaseType as a `type` argument")
	assert_null(result.get_value(), "Expected to have null value")


func test_create_with_type_not_supported_by_type_factory_expect_any_type_argument_and_error():
	var result = ArgumentFactory.create("some-name", -1)
	var result_value = result.get_value()
	assert_is(result_value, Argument, "Expected to have fallback value")
	assert_is(result_value.get_type(), AnyType)
	assert_is(result.get_error(), Error, "Expected to have error because argument factory only works with TYPE_INT and BaseType as a `type` argument")
