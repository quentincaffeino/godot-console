
extends "res://addons/gut/test.gd"

const StringType = preload("res://addons/quentincaffeino/console/src/Type/StringType.gd")


# @var  StringType
var type

func before_each():
	self.type = StringType.new()


func test_normalize_with_string_expect_same_string():
	var any_value = "any value"
	assert_eq(any_value, self.type.normalize(any_value))


func test_normalize_with_number_expect_same_number_but_stringified():
	var number = 0x616e79
	assert_eq(str(number), self.type.normalize(number))
