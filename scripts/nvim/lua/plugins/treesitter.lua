-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
      		"bash",
			"css",
      		"lua",
      		"markdown",
      		"markdown_inline",
      		"vim",
      		"vimdoc"
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}