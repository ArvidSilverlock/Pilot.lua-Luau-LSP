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

Due to lune you have to add `--` after `pilot-generate` for any command options to work (i.e., `lune run pilot-generate -- -o ./workspace`).

## Command Options for `pilot-setup`
- `--luaulsp` specifies to generate Pilot.lua types and module definitions.
- `--darklua` specifies to add a `darklua.json`.
- `--selene` specifies to add a `selene.toml` and `pilot.yml` (`pilot.yml` will only generate if the `--luaulsp` option is present).
- `--rokit` specifies to setup `rokit.toml`.

Example: `lune run pilot-setup ./workspace types`

## Command Options for `pilot-generate`directory>`, the value of this defaults to `types`.
-- `--selene` option defines whether or not to generate a `pilot.yml` for selene.

## Command Options for both.
- You can specify the location to generate it in by doing `-o <path>`, this defaults to `./workspace`.
- You can specify the subdirectory of the output location to place the types in by doing `--types-dir=<type-directory>`, this defaults to `types`.