using Godot;

public partial class CommandBuilder : GodotObject
{
    private GodotObject _commandObject;

    public CommandBuilder(GodotObject commandObject)
    {
        _commandObject = commandObject;
    }

    public CommandBuilder SetDescription(string description)
    {
        _commandObject.Call("set_description", description);
        return this;
    }

    public CommandBuilder AddArgument(string argumentName, Variant.Type argumentType)
    {
        _commandObject.Call("add_argument", argumentName, (long)argumentType);
        return this;
    }

    public CommandBuilder Register()
    {
        _commandObject.Call("register");
        return this;
    }
}
