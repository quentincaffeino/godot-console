
extends "res://addons/gut/test.gd"

const BoolType = preload("res://addons/quentincaffeino/console/src/Type/BoolType.gd")


# @var  BoolType
var type

func before_each():
	type = BoolType.new()


func test_normalize_with_true_expect_true():
	var value = "true"
	assert_true(type.normalize(value))


func test_normalize_with_one_expect_true():
	var value = "1"
	assert_true(type.normalize(value))


func test_normalize_with_false_expect_false():
	var value = "false"
	assert_false(type.normalize(value))


func test_normalize_with_zero_expect_false():
	var value = "0"
	assert_false(type.normalize(value))


func test_normalize_with_any_value_expect_false():
	var value = "any value"
	assert_false(type.normalize(value))
