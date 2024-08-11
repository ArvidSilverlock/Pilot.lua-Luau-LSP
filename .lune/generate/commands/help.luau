local order = { "setup", "generate" }

local HELP_CONTENT = {
	setup = [[setup

Creates a `workspace` directory with:
 - The visual studio code `settings.json` filled out with configurations for Luau LSP
 - A `types` directory with a `modules` subdirectory containing the module types, this `types` directory is the target for the `documentation.d.json` and `global.d.luau` files

This directory should be opened as the root of the project to acheieve intellisense. You may also drag the `.vscode` and `types` folders into a separate pre-existing folder.

This command is non-destructive and will leave any extra settings in the `settings.json` untouched, it will also leave extra modules you have created untouched.]],
	generate = [[generate [yaml|json]

This command should be run after `setup`, it generates the type and documentation files based off of either `documentation.json` or `documentation.yaml` (depending on the parameter you passed to the command).

If you pass in `json` to the function, it will overwrite the contents of the YAML file to match the content of the JSON file, this will happen the other way around as well.]],
}

return function(command)
	if command then
		print(HELP_CONTENT[command])
	else
		for _, commandName in order do
			print(HELP_CONTENT[commandName], "\n\n")
		end
	end
end
