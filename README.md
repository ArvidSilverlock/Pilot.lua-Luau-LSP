> Note: This requires [Luau LSP](https://github.com/JohnnyMorganz/luau-lsp), it will not work with alternatives such as Roblox LSP.

Run `lune run pilot/generate/generate.luau` (install [lune](https://github.com/lune-org/lune) if you don't already have it).

This will produce two files, `global.d.luau` and `documentation.d.json` (both located in the `pilot` directory).

Then add the following to your `./vscode/settings.json` file.
```json
{
	"luau-lsp.sourcemap.enabled": false,
	"luau-lsp.platform.type": "roblox",
	"luau-lsp.types.definitionFiles": ["./pilot/global.d.luau"],
	"luau-lsp.types.documentationFiles": ["./pilot/documentation.d.json"],
	"luau-lsp.require.directoryAliases": {
		"": "./pilot/modules",
	}
}
```
> Note: If you are working in a separate repo, you need to pull over the `pilot` folder, you may remove the `generate` subdirectory.

After that, press Ctrl+Shift+P and type `Luau: Reload Language Server`. You should then have working Pilot.lua types in any lua(u) file under the jurisdiction of your `settings.json`.