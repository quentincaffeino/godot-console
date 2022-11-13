
extends "res://addons/gut/test.gd"

const FuncRefCallbackBuilder = preload("res://addons/@quentincaffeino/godot-callback/src/FuncRefCallbackBuilder.gd")
const FuncRefCallback = preload("res://addons/@quentincaffeino/godot-callback/src/FuncRefCallback.gd")


class TestClass:

	func method():
		pass


func test_shoild_build_funcref_callback():
	var obj = TestClass.new()
	var fr = funcref(obj, "method")
	var cb = FuncRefCallbackBuilder.new(fr)

	var result = cb.build()

	assert_is(result, FuncRefCallback)
	assert_eq(result._target, fr)
