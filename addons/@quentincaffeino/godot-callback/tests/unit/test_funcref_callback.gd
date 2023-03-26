
extends "res://addons/gut/test.gd"

const FuncRefCallback = preload("res://addons/@quentincaffeino/godot-callback/src/FuncRefCallback.gd")


func test_bind():
	# Create a mock FuncRef target
	var mock_target = Mock.new()

	# Create a FuncRefCallback instance with the mock target
	var callback = FuncRefCallback.new(mock_target)

	# Bind an argument to the callback and assert that the bound arguments have been stored
	callback.bind(["arg1", "arg2"])
	var expected = ["arg1", "arg2"]
	var actual = callback._bind_argv
	assert_equal(expected, actual)

	# Assert that the target method was not called
	assert_false(mock_target.has_call("set_return"))


func test_ensure():
	# Create a mocked target object
	var mock_target = Mock.new()
	mock_target.mock("is_valid", true)

	# Create a callback with the mocked target
	var callback = FuncRefCallback.new(mock_target)

	# Ensure the callback target exists
	assert(callback.ensure())

	# Mock the target to return false
	mock_target.mock("is_valid", false)

	# Ensure the callback target does not exist
	assert(!callback.ensure())

	# Verify that the "is_valid" method was called on the target
	mock_target.verify("is_valid")


func test_call():
	# Create a mock FuncRef target
	var mock_target = Mock.new()

	# Create a FuncRefCallback instance with the mock target
	var callback = FuncRefCallback.new(mock_target)

	# Bind some arguments to the callback
	callback.bind(["arg1", "arg2"])

	# Set up the mock FuncRef target to return a value
	mock_target.set_return("success")

	# Call the callback and assert that it returns the expected value
	var expected = "success"
	var actual = callback.call()
	assert_equal(expected, actual)

	# Assert that the target method was called with the correct arguments
	var expected_args = [["arg1", "arg2"]]
	assert_true(mock_target.has_call("call_funcv", expected_args))
	assert_true(mock_target.call_count("call_funcv", expected_args) == 1)
