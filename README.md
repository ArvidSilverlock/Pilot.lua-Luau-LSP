## Installation

Navigate to the [releases](https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP/releases) and download the latest `workspace.zip`, unzip it, and open it in Visual Studio Code.

You'll need to install the [Luau LSP](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) visual studio code extension.

Note that this is, by default, set up for usage with Visual Studio Code. If you're a neovim user or use some other editor, I trust you're smart enough to set it up properly on your own.

## Building From Source

> [!IMPORTANT]  
> Do _not_ attempt this route if you are not technically oriented, many have tried, and failed, despite how simple it looks. Read the 'Installation' section if you think you fall into this category.

If you want to contribute, or want more control over the generation, you'll need to install this repo locally with some other tools to run the Luau code.

Install [lune](https://lune-org.github.io/docs), a Luau runtime, note, only install this when the steps require you to, and install it _within_ the specified directory (unless of course, you know what you're doing).
Make sure you install lune 0.10.2!

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

### Optional

Install [rokit](https://github.com/rojo-rbx/rokit), a toolchain manager, you may have already installed this when installing lune.

Install [darklua](https://darklua.com), which has a Luau file bundler.

Install [selene](https://kampfkarren.github.io/selene), a Luau linter.

## Command Line Options

| Option                                          | Description                                                                                                                                                          |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--notypes`                                     | Skip generation of Pilot.lua type definitions.                                                                                                                       |
| `--nodocs`                                      | Skip generation of Pilot.lua documentation.                                                                                                                          |
| `--nomodules`                                   | Skip generation of Pilot.lua module definitions.                                                                                                                     |
| `--novscode`                                    | Do not create a `.vscode` folder. This folder typically includes VS Code settings, Luau LSP configurations, code snippets, and a list of recommended extensions.     |
| `--snippet-casing=camel\|snake\|pascal\|manual` | Sets the casing style for variables in the `getp[oa]rt` VS Code snippets. <br>- `manual`: Disables automatic casing based on class names. <br>- Defaults to `camel`. |
| `--snippet-part-message="no <part>"`            | Sets the default error message inserted by the `getpart` snippet.                                                                                                    |
| `--snippet-port-message="no <part> on <port>"`  | Sets the default error message inserted by the `getport` snippet.                                                                                                    |
| `--darklua`                                     | Generate a `.darklua.json` file for DarkLua configuration.                                                                                                           |
| `--selene`                                      | Generate a `selene.toml` and `pilot.yml` file for Selene linting and Pilot integration.                                                                              |
| `--rokit`                                       | Generate a `rokit.toml` configuration file.                                                                                                                          |
| `--wiki`                                        | Generate markdown files for all documentation in the designated wiki docs directory.                                                                                 |
| `-o <path>`                                     | Output directory for all generated files. <br>- Defaults to `./workspace`.                                                                                           |
| `--types-dir=<type-directory>`                  | Subdirectory (within the output directory) where types, documentation, and modules are placed. <br>- Defaults to `types`.                                            |

## Credits

The source code for several roblox related projects are included within the `documentation/modules` directory, these include:

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
