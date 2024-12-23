return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = "VeryLazy",
    -- event = "InsertEnter",
    build = ":Copilot auth",
    init = function()
      vim.g.copilot_assume_mapped = true
    end,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 150,
        keymap = {	 
          accept = "<M-l>",
          next = "<M-j>",
          prev = "<M-k>",
        }
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.pick",
      "hrsh7th/nvim-cmp",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    config = true,
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },
      display = {
        action_palette = { provider = "mini_pick"},
        chat = {
          show_settings = false,
          render_headers = false,
          show_header_separator = false,
          start_in_insert_mode = true, 
        }
      },
      opts = { log_level = "DEBUG" },
      prompt_library = {
        ["Write Mermaid Diagrams"] = {
          strategry = "chat",
          description = "Generate mermaid diagrams prompt",
          prompts = {
            { 
            }
          }
        }
      }
    }
  }


}
