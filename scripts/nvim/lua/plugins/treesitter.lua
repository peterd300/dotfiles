return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",  "lua", "vim", "vimdoc", "markdown", "markdown_inline",
      })

      -- highlighting is now turned on by Neovim itself, not the plugin
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end
          pcall(vim.treesitter.start, args.buf) -- silently skips filetypes with no parser
        end,
      })
    end,
  },
}
