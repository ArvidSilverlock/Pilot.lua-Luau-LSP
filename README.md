## Installation

Install the [Luau LSP](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) visual studio code extension.

Install [lune](https://lune-org.github.io/docs), a luau runtime.

### Optional

Install [rokit](https://github.com/rojo-rbx/rokit), a toolchain manager.

Install [selene](https://kampfkarren.github.io/selene), a luau linter.

Install [darklua](https://darklua.com), which has a luau file bundler.

Run these commands in order:

```
git clone https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP.git
cd Pilot.lua-Luau-LSP
lune run pilot-generate
```

Open the generated `workspace` folder as the root folder in visual studio code.

Due to lune you have to add `--` after `pilot-generate` for any command options to work (i.e., `lune run pilot-generate -- -o ./workspace`).

## Command Options

-   `--notypes` - don't generate Pilot.lua type definitions.
-   `--nodocs` - don't generate Pilot.lua documentation.
-   `--nomodules` - don't generate Pilot.lua module definitions.
-   `--novscode` - don't add a `.vscode/settings.json` and `.vscode/extensions.json`.
-   `--darklua` - generate a `.darklua.json`.
-   `--selene -` generate a `selene.toml` and `pilot.yml`.
-   `--rokit` - setup `rokit.toml`.
-   `--wiki` - generates all the wiki markdown files in the wiki docs directory.
-   `-o <path>` - location to generate everything in, defaults to `./workspace`.
-   `--types-dir=<type-directory>` - subdirectory of the output location to place the types, docs and modules in, defaults to `types`.
