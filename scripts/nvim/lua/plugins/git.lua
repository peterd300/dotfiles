return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]c", function() require("gitsigns").next_hunk() end, "Git: Next hunk")
        map("n", "[c", function() require("gitsigns").prev_hunk() end, "Git: Previous hunk")
        map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, "Git: Stage hunk")
        map("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, "Git: Reset hunk")
        map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, "Git: Preview hunk")
        map("n", "<leader>hb", function() require("gitsigns").blame_line() end, "Git: Blame line")
      end,
    })
  end,
}
