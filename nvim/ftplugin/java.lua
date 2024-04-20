-- A little bit of extra work to make sure this will work in my flake shells and
-- on normal (FHS compliant) Linux installations
local nix_store_path = os.getenv("JDTLS_STORE_PATH")
local jdtls_install_path
local jdtls_local_dir
local jdtls_config_dir
local jdtls_launcher_path
if nix_store_path ~= nil then
	jdtls_install_path = nix_store_path .. "/share/java/jdtls"
	local launcher_grep = io.popen("ls " .. jdtls_install_path .. "/plugins | grep org.eclipse.equinox.launcher_", "r")
	if launcher_grep ~= nil then
		jdtls_launcher_path = jdtls_install_path .. "/plugins/" .. launcher_grep:read("*l")
		launcher_grep:close()
	end
	jdtls_local_dir = os.getenv("JDTLS_LOCAL_DIR")
	jdtls_config_dir = jdtls_local_dir .. "/config"
	local config = {
		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {

			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dosgi.sharedConfiguration.area=" .. jdtls_install_path .. "/config_linux",
			"-Dosgi.sharedConfiguration.area.readOnly=true",
			"-Dosgi.checkConfiguration=true",
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
			jdtls_launcher_path,

			"-configuration",
			jdtls_config_dir,

			"-data",
			jdtls_local_dir .. "/data",
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

	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require("jdtls").start_or_attach(config)
else
	if jdtls_install_path == nil then
		print("Error: No JDTLS installation found!")
	else
		-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
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

				"-jar",
				jdtls_launcher_path,

				"-configuration",
				jdtls_config_dir,

				"-data",
				jdtls_local_dir .. "/data",
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

		-- This starts a new client & server,
		-- or attaches to an existing client & server depending on the `root_dir`.
		require("jdtls").start_or_attach(config)
	end
end
