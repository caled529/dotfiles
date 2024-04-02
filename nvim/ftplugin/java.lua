-- NixOS stuff for finding where the jdtls package is installed and then some
-- grep to get the eclipse launcher file we need.
local handle = io.popen("nix eval nixpkgs#jdt-language-server.outPath --raw")
local jdtls_nixos_store_path
local eclipse_launcher
if handle then
	jdtls_nixos_store_path = handle:read("*a")
	handle:close()
	handle = io.popen(
		"ls -a " .. jdtls_nixos_store_path .. "/share/java/jdtls/plugins/ | cat | grep org.eclipse.equinox.launcher_"
	)
	if handle then
		eclipse_launcher = handle:read("*a"):sub(1, -2) -- Remove the linebreak at the end
		handle:close()
	end
end

-- Determine the name of the project by the root directory of the git repo
handle = io.popen("git rev-parse --show-toplevel | sed 's:.*/::'")
local project_name
if handle then
	project_name = handle:read("*a"):sub(1, -2)
	handle:close()
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dosgi.checkConfiguration=true",
		"-Dosgi.sharedConfiguration.area=" .. jdtls_nixos_store_path .. "/share/java/jdtls/config_linux",
		"-Dosgi.sharedConfiguration.area.readOnly=true",
		"-Dosgi.configuration.cascaded=true",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jdtls_nixos_store_path .. "/share/java/jdtls/plugins/" .. eclipse_launcher,
		"-configuration",
		jdtls_nixos_store_path .. "/share/java/jdtls/config_linux",
		"-data",
		"~/.eclipse/jdtls/data" .. project_name,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
