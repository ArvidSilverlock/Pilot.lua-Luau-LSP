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
lune run pilot-setup
```
Open the generated `workspace` folder as the root folder in visual studio code.

## Command Options for `pilot-setup`
- The first argument is the location to set it up in, defaults to `./workspace`.
- The second argument is the subdirectory to put the types in, defaults to `types`.

Example: `lune run pilot-setup ./workspace types`

## Command Options for `pilot-generate`
- You can specify the location to generate it in by doing `-o <path>`, this defaults to `./workspace`.
- You can specify the subdirectory of the output location to place the types in by doing `--types-dir=<types directory>`, the value of this defaults to `types`.
- Due to lune you have to add `--` after `pilot-generate` for these options to work (i.e., `lune run pilot-generate -- -o ./workspace`).
