
extends Reference


const package_name = "quentincaffeino/godot-callback"

const errors = {
	"build_factory.target": package_name + ": build: Target must be an object. Provided: %s.",

	"build.name": package_name + ": build: Name must be a type of string. Provided: %s.",

	"target_missing_member": package_name + ": ensure: Target is missing provided member. (%s, %s)",

	"ensure.target_destroyed": package_name + ": ensure: Failed to call a callback, target was previously destroyed. (%s)",

	"call.ensure_failed": package_name + ": call: Failed to call a callback, ensuring failed. (%s, %s)",
	"call.unknown_type": package_name + ": call: Unable to call unknown type. (%s, %s)",
}
