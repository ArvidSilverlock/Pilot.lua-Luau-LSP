## Installation
Install the [Luau LSP](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) visual studio code extension.

Install [lune](https://lune-org.github.io/docs), a luau runtime.

Run these commands in order:
```
git clone https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP.git
cd Pilot.lua-Luau-LSP
lune run pilot -- --setup
```
Open the generated `workspace` folder as the root folder in visual studio code.

## Command Options
- You can specify the location to generate it in by doing `-o <path>`, this defaults to `./workspace`.
- You can specify the subdirectory of the output location to place the types in by doing `--types=<types directory>`, the value of this defaults to `types`.
- You can specify the documentation file to source data from by doing `--source=yaml` or `--source=json-`. This defaults to `json`.
- Due to lune you have to add `--` after `pilot` for these options to work.