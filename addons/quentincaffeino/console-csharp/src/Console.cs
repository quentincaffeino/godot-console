using Godot;

public class Console : Node
{
    CanvasLayer _console;

    public override void _Ready()
    {
        _console = GetTree().Root.GetNode<CanvasLayer>("Console");
    }

    public CommandBuilder AddCommand(string name, Godot.Object target, string targetMethodName)
    {
        Godot.Object consoleCommand = _console.Call("add_command", name, target, targetMethodName) as Godot.Object;
        return new CommandBuilder(consoleCommand);
    }
}
