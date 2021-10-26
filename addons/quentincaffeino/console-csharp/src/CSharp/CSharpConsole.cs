using Godot;
public class CSharpConsole : Node
{    
	CanvasLayer _console;
	public override void _Ready()
	{
		_console = GetTree().Root.GetNode<CanvasLayer>("Console");
	}	

	public CSharpCommand AddCommand(string name, Godot.Object target, string targetMethodName) {
		Godot.Object consoleCommand = _console.Call("add_command", name, target, targetMethodName) as Godot.Object;
		return new CSharpCommand(consoleCommand);
	}
}

public class CSharpCommand: Godot.Object {
	private Godot.Object _commandObject;
	public CSharpCommand(Godot.Object commandObject) {
		_commandObject = commandObject;
	}
	
	public CSharpCommand SetDescription(string description) {
		_commandObject.Call("set_description", description);
		return this;
	}

	public CSharpCommand AddArgument(string argumentName, Variant.Type argumentType) {
		_commandObject.Call("add_argument", argumentName, argumentType);
		return this;
	}

	public CSharpCommand Register() {
		_commandObject.Call("register");
		return this;
	}
}
