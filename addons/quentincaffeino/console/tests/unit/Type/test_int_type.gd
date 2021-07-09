
extends "res://addons/gut/test.gd"

const IntType = preload("res://addons/quentincaffeino/console/src/Type/IntType.gd")


# @var  IntType
var type

func before_each():
	type = IntType.new()


func test_normalize_with_int_expect_same_int():
	var any_value = "5"
	assert_eq(5, type.normalize(any_value))
