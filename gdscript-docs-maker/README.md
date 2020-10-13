# GDScript Docs Maker

![Project banner](./assets/gdscript-docs-maker-banner.svg)

Docs Maker is a set of tools to convert documentation you write inside your code to an online or offline code reference in the markdown format.

If you make plugins or a framework for Godot, GDScript Docs Maker will help you save a lot of time documenting your code.

It creates documents following Godot's built-in class reference. You can see an example with our [Godot Steering Toolkit documentation](https://www.gdquest.com/docs/godot-steering-toolkit/reference/)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->

**Table of Contents**

- [Installing](#installing)
- [Getting Started](#getting-started)
  - [Writing your code reference](#writing-your-code-reference)
  - [Generating the markdown files](#generating-the-markdown-files)
- [Hugo output](#hugo-output)
- [The manual way](#the-manual-way)
  - [Converting JSON](#converting-json)

<!-- markdown-toc end -->

**Note**: This program requires Godot 3.2+ and Python 3.7+ to work.

## Installing

You can install the GDScript Docs Maker python package with pip:

```bash
# On Linux and MacOS:
python3 -m pip install gdscript_docs_maker

# On Windows, if you installed Python 3.7+, you can use:
python -m pip install gdscript_docs_maker
```

Although to use the shell script that simplifies creating the reference, `generate_reference`, you need to clone this repository. More on that below.

## Getting Started

In this section, you will learn to use the program to generate a code reference quickly.

This involves two steps. You need to:

1. Write docstrings inside your GDScript code.
2. Use one of the shell programs that ships with this add-on.

### Writing your code reference

Docstring or doc-comments in GDScript don't have any special markup.

You can document classes, properties, and functions with comment blocks placed on the line before their definition:

```gdscript
# A linear and angular amount of acceleration.
class_name GSTTargetAcceleration


# Linear acceleration
var linear: = Vector3.ZERO
# Angular acceleration
var angular: = 0.0


# Resets the accelerations to zero
func reset() -> void:
	linear = Vector3.ZERO
	angular = 0.0
```

If you need long docstrings, you can use multiple commented lines:

```
# A specialized steering agent that updates itself every frame so the user does
# not have to using a KinematicBody2D
# category: Specialized agents
extends GSAISpecializedAgent
class_name GSAIKinematicBody2DAgent
```

### Generating the markdown files

We wrote two shell scripts to automate the steps in generating a code reference: `./generate_reference` for Linux or MacOS, and `./generate_reference.bat` for Windows.

Use either of them to quickly generate your code reference:

```bash
Generate a code reference from GDScript
Usage:
generate_reference $project_directory [options]

Required arguments:

$project_directory -- path to your Godot project directory.
This directory or one of its subdirectories should contain a
project.godot file.

Flags:

-h/--help             -- Display this help message.
-o/--output-directory -- directory path to output the documentation into.
-f/--format           -- Either `markdown` or `hugo`. If `hugo`, the output document includes a TOML front-matter at the top. Default: `markdown`.
-a/--author           -- If --format is `hugo`, controls the author property in the TOML front-matter.
```

To use them:

- You need to clone this repository or download the source code from a [stable release](https://github.com/GDQuest/gdscript-docs-maker/releases).
- You need `godot` to be available on the [system PATH variable](<https://en.wikipedia.org/wiki/PATH_(variable)>).

## Hugo output

You can output markdown files for [hugo](https://gohugo.io/), the static website engine.

To do so, call GDScript docs maker with the `--format hugo` option. You can use two extra flags with this:

```bash
--date YYYY-MM-DD, the date in iso format, if you want the documents to have a date other than today. Default: datetime.date.today()
--author author_id, the id of the author on your hugo website, to assign an the author for the documents. Default: ""
```

Here's how I generate the Godot Steering Toolkit's documentation. This command outputs the class reference straight into the website:

```bash
python3 -m gdscript_docs_maker $HOME/Repositories/godot-steering-toolkit/project/reference.json --format hugo --author razoric --path $HOME/Repositories/website/content/docs/godot-steering-toolkit/reference/classes/
```

## The manual way

If you want to generate the JSON and convert it manually, there are three steps involved:

1. Copying the GDScript files `./godot-scripts/Collector.gd` and `./godot-scripts/ReferenceCollectorCLI.gd` or `./godot-scripts/ReferenceCollectorCLI.gd` to your Godot 3.2 project.
2. Running the GDScript code with Godot, either from the editor (`ReferenceCollector.gd`) or by calling Godot from the command line (`ReferenceCollectorCLI.gd`).
3. Running `gdscript_docs_maker` on the reference.json file that Godot generated in the previous step.

<!-- TODO: turn into a note block on the website. -->

**Note**: to parse and collect data from GDScript code, we rely on the GDScript language server that's new in Godot 3.2.

### Converting JSON

Call the `gdscript-docs-maker` package directly using the `python -m` option:

```
Usage: gdscript_docs_maker [-h] [-p PATH] [-v] [--dry-run] files [files ...]

Merges or converts json data dumped by Godot's GDScript language server to
create a code reference.

positional arguments:
  files                 A list of paths to JSON files.

optional arguments:
  -h, --help            Show this help message and exit.
  -p PATH, --path PATH  Path to the output directory.
  -v, --verbose         Set the verbosity level. For example, -vv sets the
                        verbosity level to 2. Default: 0.
  --dry-run             Run the script without creating
                        files and folders. For debugging purposes.
```

The program takes a list of JSON files. For example, we generate the code reference of our AI framework [Godot Steering Toolkit](https://github.com/GDQuest/godot-steering-toolkit/) like so with the shell:

```fish
python -m gdscript-docs-maker ~/Repositories/godot-steering-toolkit/src/reference.json
```
