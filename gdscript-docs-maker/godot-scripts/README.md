# Collect the reference from the Godot editor #

Godot, since version 3.2, has a tool to create a class reference from GDScript code, through its language server.

This folder contains a tool script, `ReferenceCollector.gd`, to run directly from within your Godot projects and get the class reference as JSON using File->Run in the script editor.

You can find more detailed instructions inside the GDScript code itself.

## CLI version ##

An alternative to running the EditorScript is to use a command-line version of the tool found in the root of the repository. It requires Godot to be in the PATH environment variable.

- **Windows**
```bash
generate_reference path\to\project project-name
```
- **Unix**
```bash
./generate_reference path/to/project project-name
```

- The first parameter should be a path to a directory that contains a `project.godot` file.
- `project-name` is the folder the distribution will be output into

This script will copy the collector CLI script, run godot and quit, run the python module, and output the results into `project-name`.
