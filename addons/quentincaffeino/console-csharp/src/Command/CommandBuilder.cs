using Godot;

public class CommandBuilder : Godot.Object
{
    private Godot.Object _commandObject;

    public CommandBuilder(Godot.Object commandObject)
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
        _commandObject.Call("add_argument", argumentName, argumentType);
        return this;
    }

    public CommandBuilder Register()
    {
        _commandObject.Call("register");
        return this;
    }
}
