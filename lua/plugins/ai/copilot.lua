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
    keys = {
      { "ga", "<cmd>CodeCompanionChat Add<cr>", "v", desc = "Add to Chat", noremap=true, silent=true},
      { "<C-g>", "<cmd>CodeCompanionChat Add<cr>", "v", desc = "Add to Chat", noremap=true, silent=true},
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", "n", desc = "Toggle CodeCompanion Chat", noremap=true, silent=true},
      { "<C-g>", "<cmd>CodeCompanionChat Toggle<cr>", "n", desc = "Toggle CodeCompanion Chat", noremap=true, silent=true},
      { "<leader>ce", "<cmd>CodeCompanionExplain<cr>", "v", desc = "Explain Selected Code", noremap=true, silent=true},
      { "<leader>cr", "<cmd>CodeCompanionRefactor<cr>", "v", desc = "Refactor Selected Code", noremap=true, silent=true},
      { "<leader>cg", "<cmd>CodeCompanionGenerate<cr>", "n", desc = "Generate Code Snippet", noremap=true, silent=true}
    },
    opts = {
      adapters ={
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key =vim.env.OPENAI_API_KEY,
            },
            schema = {
              model = {
                default = "gpt-5-mini",
              },
            },
          })
        end,
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,  -- Show mcp tool results in chat
            make_vars = true,            -- Convert resources to #variables
            make_slash_commands = true,  -- Add prompts as /slash commands
          }
        }
      },
      strategies = {
        chat = { 
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
          slash_commands = {
            ["buffer"] = { opts = { provider = "fzf_lua"}},
            ["file"] = { opts = { provider = "fzf_lua"}},
            ["help"] = { opts = { provider = "fzf_lua"}},
            ["symbols"] = { opts = { provider = "fzf_lua"}}
          }
        },
        inline = { adapter = "copilot" },
      },
      display = {
        chat = {
          show_settings = true,
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
  },

  { "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = "avante.md",
      providers = {
        openai = {
          model= "gpt-5-mini"
        },
        copilot = {
          -- try to use claude sonnet 4 as model from copilot
          model="claude-sonnet-4"
        },
      },
      provider = "copilot",
    },
    keys = {
      {
        "<leader>a+",
        function()
          local tree_ext = require("avante.extensions.nvim_tree")
          tree_ext.add_file()
        end,
        desc = "Select file in NvimTree",
        ft = "NvimTree",
      },
      {
        "<leader>a-",
        function()
          local tree_ext = require("avante.extensions.nvim_tree")
          tree_ext.remove_file()
        end,
        desc = "Deselect file in NvimTree",
        ft = "NvimTree",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- below optional dependencies
      "echasnovski/mini.pick",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",
    },
  },

}
