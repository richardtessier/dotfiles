return {
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "moon",
			on_highlights = function(hl, c)
				-- On remplace les fonds intenses par des versions très sombres
				hl.DiffAdd = { bg = "#1e2d24", fg = "NONE" } -- Vert très sombre
				hl.DiffChange = { bg = "#1a2030", fg = "NONE" } -- Bleu très sombre
				hl.DiffDelete = { bg = "#37222c", fg = "NONE" } -- Rouge/Brun sombre
				hl.DiffText = { bg = "#2e3c64", fg = "NONE" } -- Surbrillance de la modif
			end,
		},
	},
}
