-- Luasnip config
local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			virt_text = { { "<-", "Error" } },
		},
	},
})

-- c-k expansion key
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

-- c-j jump backward
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { silent = true })

-- c-l selecting within list of options
vim.keymap.set({ "i" }, "<c-l>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)
