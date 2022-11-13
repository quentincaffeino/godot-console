
extends "res://addons/gut/test.gd"

const Utils = preload("res://addons/@quentincaffeino/godot-callback/src/Utils.gd")


class TestClass:

	var property = null

	func method():
		pass


class TestGetType:
	extends "res://addons/gut/test.gd"

	func test_should_identify_as_method():
		var obj = TestClass.new()
		var expected_result = Utils.Type.METHOD

		var result = Utils.get_type(obj, "method")

		assert_eq(result, expected_result)

	func test_should_identify_as_value():
		var obj = TestClass.new()
		var expected_result = Utils.Type.PROPERTY

		var result = Utils.get_type(obj, "property")

		assert_eq(result, expected_result)

	func test_should_identify_as_unknow():
		var obj = TestClass.new()
		var expected_result = Utils.Type.UNKNOWN

		var result = Utils.get_type(obj, "ytreporp")

		assert_eq(result, expected_result)


class TestIsFuncRef:
	extends "res://addons/gut/test.gd"
		
	func test_on_not_funcref_should_return_false():
		var obj = TestClass.new()

		var result = Utils.is_funcref(obj)

		assert_false(result)

	func test_on_funcref_should_return_true():
		var obj = TestClass.new()
		var fr = funcref(obj, "method")

		var result = Utils.is_funcref(fr)

		assert_true(result)
