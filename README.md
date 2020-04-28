
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-12-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Godot Console
============

In-game console for Godot, easily extensible with new commands.

![Screenshot of in-game console for Godot](https://github.com/quentincaffeino/godot-console/blob/dev/screenshot.png)

## Features

- Writing to console using `write` and `writeLine` method. You can use [BB codes](https://godot.readthedocs.io/en/latest/learning/features/gui/bbcode_in_richtextlabel.html?highlight=richtextlabel#reference). (Also printed to engine output)

	`Console.writeLine('Hello world!')`

- <strike>Auto-completion on `TAB` (complete command)</strike> (broken right now), `Enter` (complete and execute).
- History (by default using with actions `ui_up` and `ui_down`)
- Custom types (`Filter`, `IntRange`, `FloatRange`, [and more...](docs/Type/Type.md))
- [Logging](https://github.com/quentincaffeino/godot-console/tree/master/docs/Log.md)
- [FuncRef](https://docs.godotengine.org/en/3.2/classes/class_funcref.html) support with Godot >=3.2 (command target).

## Installation

1. Clone or download this repository to your project `res://addons/quentincaffeino-console` folder.
2. Enable console in Project/Addons
3. Add new actions to Input Map: `console_toggle`, `ui_up`, `ui_down`

## Example:

### Usage we will get:

```
$ sayHello "Adam Smith"
Hello Adam Smith!
```

### Function that will be called by our command:

```gdscript
func printHello(name = ''):
	Console.writeLine('Hello ' + name + '!')
```

### Registering command:

```gdscript
func _ready():
	# 1. argument is command name
	# 2. arg. is target (target could be a funcref)
	# 3. arg. is target name (name is not required if it is the same as first arg or target is a funcref)
	Console.addCommand('sayHello', self, 'printHello')\
		.setDescription('Prints "Hello %name%!"')\
		.addArgument('name', TYPE_STRING)\
		.register()
```

For old method for registering commands please read [this](docs/Registering-Command-Old.md)

----------

Great thanks to [@Krakean](https://github.com/Krakean) and [@DmitriySalnikov](https://github.com/DmitriySalnikov) for the motivation to keep improving the [original](https://github.com/Calinou/godot-console) console by [@Calinou](https://github.com/Calinou).

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://gitlab.com/quentincaffeino"><img src="https://avatars3.githubusercontent.com/u/2855777?v=4" width="100px;" alt=""/><br /><sub><b>Sergei ZH</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/commits?author=quentincaffeino" title="Code">💻</a> <a href="#question-quentincaffeino" title="Answering Questions">💬</a> <a href="https://github.com/quentincaffeino/godot-console/commits?author=quentincaffeino" title="Documentation">📖</a> <a href="#ideas-quentincaffeino" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/quentincaffeino/godot-console/pulls?q=is%3Apr+reviewed-by%3Aquentincaffeino" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="http://www.underflowstudios.com"><img src="https://avatars3.githubusercontent.com/u/420072?v=4" width="100px;" alt=""/><br /><sub><b>Michael Brune</b></sub></a><br /><a href="#a11y-MJBrune" title="Accessibility">️️️️♿️</a> <a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3AMJBrune" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/aganm"><img src="https://avatars0.githubusercontent.com/u/20380758?v=4" width="100px;" alt=""/><br /><sub><b>Michael Aganier</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3Aaganm" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/hpn33"><img src="https://avatars1.githubusercontent.com/u/16251202?v=4" width="100px;" alt=""/><br /><sub><b>hpn332</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3Ahpn33" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/danilw"><img src="https://avatars1.githubusercontent.com/u/24825887?v=4" width="100px;" alt=""/><br /><sub><b>Danil</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3Adanilw" title="Bug reports">🐛</a></td>
    <td align="center"><a href="http://sdnllc.com"><img src="https://avatars3.githubusercontent.com/u/2214652?v=4" width="100px;" alt=""/><br /><sub><b>Paul Hocker</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3Apaulhocker" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/SamanthaClarke1"><img src="https://avatars3.githubusercontent.com/u/24452702?v=4" width="100px;" alt=""/><br /><sub><b>Samantha Clarke</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3ASamanthaClarke1" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://hugo.pro"><img src="https://avatars3.githubusercontent.com/u/180032?v=4" width="100px;" alt=""/><br /><sub><b>Hugo Locurcio</b></sub></a><br /><a href="#a11y-Calinou" title="Accessibility">️️️️♿️</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/DmDerbin"><img src="https://avatars3.githubusercontent.com/u/6673326?v=4" width="100px;" alt=""/><br /><sub><b>Dmitry Derbin</b></sub></a><br /><a href="#question-DmDerbin" title="Answering Questions">💬</a></td>
    <td align="center"><a href="https://github.com/VitexHD"><img src="https://avatars0.githubusercontent.com/u/31520916?v=4" width="100px;" alt=""/><br /><sub><b>VitexHD</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/issues?q=author%3AVitexHD" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/hilfazer"><img src="https://avatars1.githubusercontent.com/u/29497869?v=4" width="100px;" alt=""/><br /><sub><b>hilfazer</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/commits?author=hilfazer" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/crazychenz"><img src="https://avatars2.githubusercontent.com/u/792769?v=4" width="100px;" alt=""/><br /><sub><b>Crazy Chenz</b></sub></a><br /><a href="https://github.com/quentincaffeino/godot-console/commits?author=crazychenz" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## License

Licensed under the MIT license, see `LICENSE.md` for more information.
