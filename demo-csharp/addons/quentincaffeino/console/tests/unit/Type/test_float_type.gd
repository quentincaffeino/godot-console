
extends "res://addons/gut/test.gd"

const FloatType = preload("res://addons/quentincaffeino/console/src/Type/FloatType.gd")


# @var  FloatType
var type

func before_each():
	type = FloatType.new()


func test_normalize_with_string_with_float_expect_float():
	var value = "5.5"
	assert_eq(float(value), type.normalize(value))


func test_normalize_with_string_with_float_with_comma_expect_float():
	var value = "5,6"
	var expectedValue = float(value.replace(',', '.'))
	assert_eq(expectedValue, type.normalize(value))
