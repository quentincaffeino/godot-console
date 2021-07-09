
extends "res://addons/gut/test.gd"

const BaseRegexCheckedType = preload("res://addons/quentincaffeino/console/src/Type/BaseRegexCheckedType.gd")


class SomeRegexCheckedType extends BaseRegexCheckedType:

	func _init(_pattern).('SomeRegexCheckedType', _pattern):
		pass


# @var  SomeRegexCheckedType
var type

func before_each():
	type = SomeRegexCheckedType.new('^[+-]?\\d+$')


func test_normalize_with_true_expect_true():
	var value = "1"
	assert_eq(SomeRegexCheckedType.CHECK.OK, type.check(value))
