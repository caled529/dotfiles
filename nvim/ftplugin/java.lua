local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
	},

	-- One dedicated LSP server & client will be started per unique root_dir
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

-- A little bit of extra work to allow this to work in my flake shells, and on
-- normal (FHS compliant) Linux installations

-- These can just be set manually on other systems
local jdtls_launcher_path
local jdtls_config_dir
local jdtls_data_dir

-- Environment variable I include in my nix flakes for Java
local nix_store_path = os.getenv("JDTLS_STORE_PATH")
if nix_store_path ~= nil then
	local jdtls_install_path = nix_store_path .. "/share/java/jdtls"
	-- The only way I could figure out how to complete the launcher file path was like this
	-- I don't think this would ever actually fail so I'm not checking the path afterwards
	local launcher_grep = io.popen("ls " .. jdtls_install_path .. "/plugins | grep org.eclipse.equinox.launcher_", "r")
	if launcher_grep ~= nil then
		jdtls_launcher_path = jdtls_install_path .. "/plugins/" .. launcher_grep:read("*l")
		launcher_grep:close()
	end
	-- More Environment variables from my flakes
	jdtls_config_dir = os.getenv("JDTLS_CONFIG_DIR")
	jdtls_data_dir = os.getenv("JDTLS_DATA_DIR")

	-- jdtls is installed in a read only directory on nixos, so we need this
	-- extra configuration to make things work right
	table.insert(config.cmd, "-Dosgi.sharedConfiguration.area=" .. jdtls_install_path .. "/config_linux")
	table.insert(config.cmd, "-Dosgi.sharedConfiguration.area.readOnly=true")
	table.insert(config.cmd, "-Dosgi.checkConfiguration=true")
	table.insert(config.cmd, "-Dosgi.configuration.cascaded=true")
end

if jdtls_launcher_path == nil then
	-- Helpful error message when I don't start neovim in a flake shell
	print("Error: No jdtls launcher found")
else
	-- Remaining args have to be passed after the extra config on nixos

	table.insert(config.cmd, "-jar")
	table.insert(config.cmd, jdtls_launcher_path)

	table.insert(config.cmd, "-configuration") -- can be shared between projects
	table.insert(config.cmd, jdtls_config_dir)

	table.insert(config.cmd, "-data") -- unique per project
	table.insert(config.cmd, jdtls_data_dir)

	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require("jdtls").start_or_attach(config)
end
