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
- You can specify the location to generate it in by doing `-o path/to/output`, this defaults to `./workspace`.
- You can specify the documentation file to source data from by doing `--source=yaml` or `--source=json-`. This defaults to `json`.
- Due to lune you have to add `--` after `pilot` for these options to work.