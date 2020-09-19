
extends "res://addons/gut/test.gd"

const TypeFactory = preload("res://addons/quentincaffeino-console/src/Type/TypeFactory.gd")
const BaseType = preload("res://addons/quentincaffeino-console/src/Type/BaseType.gd")
const Error = preload("res://addons/quentincaffeino-console/src/Misc/Error.gd")


func test_create_with_negative_engine_type_expect_error():
	var result = TypeFactory.create(-1)
	assert_is(result.get_error(), Error, "Expected to have error because TypeFactory only works with TYPE_INT as a `engine_type` argument")
	assert_null(result.get_value(), "Expected to have null value")


func test_create_with_valid_engine_type_expect_base_type():
	var result = TypeFactory.create(0)
	assert_null(result.get_error(), "Expected to have no error")
	assert_is(result.get_value(), BaseType, "Expected to have BaseType instance")


func test_create_with_non_int_expect_error():
	var result = TypeFactory.create(Reference.new())
	assert_is(result.get_error(), Error, "Expected to have error because TypeFactory only works with TYPE_INT as a `engine_type` argument")
	assert_null(result.get_value(), "Expected to have null value")
