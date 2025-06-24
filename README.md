## Installation

Navigate to the [releases](https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP/releases) and download the latest `workspace.zip`, unzip it, and open it in Visual Studio Code.

You'll need to install the [Luau LSP](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) visual studio code extension. If you are running a version <1.33.1 you will need to find and replace `Enum.` with `Enum` in the `global.d.luau` file, make sure you are not in regex mode, as that would cause issues.

Note that this is, by default, set up for usage with Visual Studio Code. If you're a neovim user or use some other editor, I trust you're smart enough to set it up properly on your own.

## Building From Source

If you want to contribute, or want more control over the generation, you'll need to install this repo locally with some other tools to run the Luau code.

Install [lune](https://lune-org.github.io/docs), a luau runtime, note, only install this when the steps require you to, and install it _within_ the specified directory (unless of course, you know what you're doing).

### Optional

Install [rokit](https://github.com/rojo-rbx/rokit), a toolchain manager, you may have already installed this when installing lune.

Install [selene](https://kampfkarren.github.io/selene), a luau linter.

Install [darklua](https://darklua.com), which has a luau file bundler.

### Steps

```
git clone https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP.git
cd Pilot.lua-Luau-LSP
```

Once you are within the `Pilot.lua-Luau-LSP` directory, you need to install [lune](https://lune-org.github.io/docs).

Then run:

```
lune run pilot-generate
```

You should then open the generated `workspace` folder as the root folder in visual studio code.

Due to lune you have to add `--` after `pilot-generate` for any command options to work (i.e., `lune run pilot-generate -- -o ./workspace`).

## Command Options

- `--notypes` - don't generate Pilot.lua type definitions.
- `--nodocs` - don't generate Pilot.lua documentation.
- `--nomodules` - don't generate Pilot.lua module definitions.
- `--novscode` - don't add a `.vscode/settings.json` and `.vscode/extensions.json`.
- `--darklua` - generate a `.darklua.json`.
- `--selene -` generate a `selene.toml` and `pilot.yml`.
- `--rokit` - setup `rokit.toml`.
- `--wiki` - generates all the wiki markdown files in the wiki docs directory.
- `-o <path>` - location to generate everything in, defaults to `./workspace`.
- `--types-dir=<type-directory>` - subdirectory of the output location to place the types, docs and modules in, defaults to `types`.

## Credits

The source code for several roblox related projects are included within the `pilot-modules` directory, these include:

- [cxmeel/sift](https://cxmeel.github.io/sift/), under an MIT license.
- [evaera/roblox-lua-promise](https://eryn.io/roblox-lua-promise/), under an MIT license.
- [Ozzypig/repr](https://github.com/Ozzypig/repr/), under a WTFPL license.
- [jaipack17/Nature2D](https://jaipack17.github.io/Nature2D/), under an MIT license.
- [Sleitnick/rbxts-octo-tree](https://github.com/Sleitnick/rbxts-octo-tree/), under an MIT license (which is listed [here](https://www.npmjs.com/package/@rbxts/octo-tree) rather than on the github).

The following are from [Sleitnick/RbxUtil](https://github.com/Sleitnick/RbxUtil) and are all under an MIT license.

- Signal
- Symbol
- TableUtil
- Trove
