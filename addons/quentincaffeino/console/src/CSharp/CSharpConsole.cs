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

	public CSharpCommand AddArgument(string argumentName, ConsoleArgumentType argumentType) {
		_commandObject.Call("add_argument", argumentName, argumentType);
		return this;
	}

	public CSharpCommand Register() {
		_commandObject.Call("register");
		return this;
	}
}

public enum ConsoleArgumentType {
	TYPE_NIL = 0,
	TYPE_BOOL = 1,
	TYPE_INT = 2,
	TYPE_REAL = 3,
	TYPE_STRING = 4,
	TYPE_VECTOR2 = 5,
	TYPE_RECT2 = 6,
	TYPE_VECTOR3 = 7,
	TYPE_TRANFORM2D = 8,
	TYPE_PLANE = 9,
	TYPE_QUAT = 10,
	TYPE_AABB = 11,
	TYPE_BASIS = 12,
	TYPE_TRANSFORM = 13,
	TYPE_COLOR = 14,
	TYPE_NODE_PATH = 15,
	TYPE_RID = 16,
	TYPE_OBJECT = 17,
	TYPE_DICTIONARY = 18,
	TYPE_ARRAY = 19,
	TYPE_RAW_ARRAY = 20,
	TYPE_INT_ARRAY = 21,
	TYPE_REAL_ARRAY = 22,
	TYPE_STRING_ARRAY = 23,
	TYPE_VECTOR2_ARRAY = 24,
	TYPE_VECTOR3_ARRAY = 25,
	TYPE_COLOR_ARRAY = 26,
	TYPE_MAX = 27
}
