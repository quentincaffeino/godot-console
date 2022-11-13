
extends "res://addons/gut/test.gd"

const CallbackBuilderFactory = preload("res://addons/@quentincaffeino/godot-callback/src/CallbackBuilderFactory.gd")
const CallbackBuilder = preload("res://addons/@quentincaffeino/godot-callback/src/CallbackBuilder.gd")
const FuncRefCallbackBuilder = preload("res://addons/@quentincaffeino/godot-callback/src/FuncRefCallbackBuilder.gd")


class TestClass:

	func method():
		pass

class TestCallbackBuilderFactory:
	extends CallbackBuilderFactory

	var called = false

	# @param    Reference  target
	# @returns  bool
	func _validate_target(target):
		self.called = true
		return true


func test_get_callback_builder_should_call_validate_target():
	var obj = TestClass.new()
	var cbfd = TestCallbackBuilderFactory.new()

	cbfd.get_callback_builder(obj)

	assert_true(cbfd.called)

func test_get_callback_builder_should_return_cb_builder_for_some_obj():
	var obj = TestClass.new()
	var cbf = CallbackBuilderFactory.new()

	var result = cbf.get_callback_builder(obj)

	assert_is(result, CallbackBuilder)
	assert_eq(result._target, obj)

func test_get_callback_builder_should_return_funcref_cb_builder_for_funcref():
	var obj = TestClass.new()
	var fr = funcref(obj, "method")
	var cbf = CallbackBuilderFactory.new()

	var result = cbf.get_callback_builder(fr)

	assert_is(result, FuncRefCallbackBuilder)
	assert_eq(result._target, fr)

func test_validate_target_should_return_truly_when_passed_an_object():
	var obj = TestClass.new()
	var cbf = CallbackBuilderFactory.new()

	var result = cbf._validate_target(obj)

	assert_true(result)

func test_validate_target_should_return_falsy_when_passed_anything_else():
	var cbf = CallbackBuilderFactory.new()

	var result = cbf._validate_target(null)

	assert_false(result)
