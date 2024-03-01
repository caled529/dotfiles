require("config.autocmds")
require("config.set")
-- Lazy needs to be loaded after the leader key is remapped
require("config.lazy")
-- Plugin specific keymaps need to be sourced after lazy
require("config.keymaps")
