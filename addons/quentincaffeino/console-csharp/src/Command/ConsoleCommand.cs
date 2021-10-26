using Godot;
public class ConsoleCommand: Godot.Object {
	private Godot.Object _commandObject;
	public ConsoleCommand(Godot.Object commandObject) {
		_commandObject = commandObject;
	}
	
	public ConsoleCommand SetDescription(string description) {
		_commandObject.Call("set_description", description);
		return this;
	}

	public ConsoleCommand AddArgument(string argumentName, Variant.Type argumentType) {
		_commandObject.Call("add_argument", argumentName, argumentType);
		return this;
	}

	public ConsoleCommand Register() {
		_commandObject.Call("register");
		return this;
	}
}