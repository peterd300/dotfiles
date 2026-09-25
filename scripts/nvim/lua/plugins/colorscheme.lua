-- lua/plugins/colorscheme.lua
return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- "hard", "medium", or "soft" — hard gives max contrast
    })
    vim.cmd("colorscheme gruvbox")
  end,
}