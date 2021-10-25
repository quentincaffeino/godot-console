using Godot;

public class CSharpDemoScene : CanvasLayer
{    
    CSharpConsole _wrapper;
    Label _label;
    public override void _Ready()
    {
        _wrapper = GetTree().Root.GetNode<CSharpConsole>("CSharpConsole");        
        _wrapper.AddCommand("change_csharp_label", this, nameof(ChangeLabelText))
                .SetDescription("Changes label to %newText%")
                .AddArgument("newText", ConsoleArgumentType.TYPE_STRING)
                .Register();
        _label = GetNode<Label>("Label");
    }

    public void ChangeLabelText(string newText) {
        _label.Text = newText;
    }
}

