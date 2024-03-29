-- +---------------------------------------------------------------+
-- |   _                 _                   _                     |
-- |  | |___ _ __    ___(_) __ _ _ __   __ _| |_ _   _ _ __ ___    |
-- |  | / __| '_ \  / __| |/ _` | '_ \ / _` | __| | | | '__/ _ \   |
-- |  | \__ \ |_) | \__ \ | (_| | | | | (_| | |_| |_| | | |  __/   |
-- |  |_|___/ .__/  |___/_|\__, |_| |_|\__,_|\__|\__,_|_|  \___|   |
-- |        |_|            |___/                                   |
-- +---------------------------------------------------------------+

require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
})
