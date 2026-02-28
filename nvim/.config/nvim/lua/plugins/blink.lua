return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"moyiz/blink-emoji.nvim",
			"Kaiser-Yang/blink-cmp-dictionary",
		},
		opts = {
			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					-- markdown = { inherit_defaults = true, "emoji", "dictionary" },
					markdown = { inherit_defaults = true, "emoji" },
				},
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						min_keyword_length = 2,
						opts = { insert = true },
					},
					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						min_keyword_length = 3,
						opts = {
							dictionary_files = { "/usr/share/dict/words" },
						},
					},
				},
			},
		},
	},
}
