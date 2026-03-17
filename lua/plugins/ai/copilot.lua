return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = { "InsertEnter", "BufEnter" },
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
    },
    lazy = true,
    -- Also load when entering a buffer so features (inline/commands) are
    -- available for already-open buffers and non-insert workflows.
    event = { "BufEnter", "InsertEnter" },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- ── Diff UX improvements ────────────────────────────────────────────
      local augroup = vim.api.nvim_create_augroup("AbgCodeCompanionDiff", { clear = true })

      -- When a diff is attached to a buffer, notify with the filename so the
      -- user can always tell which file is being modified (especially useful
      -- after long agentic sessions with many file edits).
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionDiffAttached",
        group = augroup,
        callback = function(ev)
          local bufnr = ev.data and ev.data.bufnr
          if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end

          local name = vim.api.nvim_buf_get_name(bufnr)
          local rel = vim.fn.fnamemodify(name, ":~:.")
          if rel == "" then rel = "[unnamed]" end

          -- Print to messages so it's visible from the chat window too
          vim.notify(
            "󰈔  Diff: " .. rel,
            vim.log.levels.INFO,
            { title = "CodeCompanion", timeout = 4000 }
          )

          -- Also stamp a winbar on every window that shows this buffer so
          -- the hint is visible at a glance while reviewing the diff.
          local hint = " 󰈔 " .. rel
            .. "   gda Accept  gdr Reject  gdy Accept-all"
            .. "  gdw Accept+write  ]c Next  [c Prev "
          vim.schedule(function()
            for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
              local ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", hint, { win = win })
              if not ok then
                -- winbar not supported in this window (e.g. a floating without it enabled)
              end
            end
          end)
        end,
      })

      local function close_diff_windows(bufnr)
        if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
        vim.schedule(function()
          for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
            pcall(vim.api.nvim_win_close, win, true)
          end
        end)
      end

      -- Clean up the winbar and close diff windows when accepted or rejected.
      vim.api.nvim_create_autocmd("User", {
        pattern = { "CodeCompanionDiffAccepted", "CodeCompanionDiffRejected" },
        group = augroup,
        callback = function(ev)
          local bufnr = ev.data and ev.data.bufnr
          if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
          close_diff_windows(bufnr)
          vim.schedule(function()
            for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
              pcall(vim.api.nvim_set_option_value, "winbar", "", { win = win })
            end
          end)
        end,
      })
    end,


    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "Toggle CodeCompanion Chat", noremap = true, silent = true },
      { "<C-g>", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "Toggle CodeCompanion Chat", noremap = true, silent = true },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat", noremap = true, silent = true },
      { "<C-g>", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat", noremap = true, silent = true },
      { "<leader>ce", "<cmd>CodeCompanionExplain<cr>", mode = { "n", "v" }, desc = "Explain Selected Code", noremap = true, silent = true },
      { "<leader>cR", "<cmd>CodeCompanionRefactor<cr>", mode = { "n", "v" }, desc = "Refactor Selected Code (AI)", noremap = true, silent = true },
      { "<leader>cg", "<cmd>CodeCompanionGenerate<cr>", mode = { "n", "v" }, desc = "Generate Code Snippet", noremap = true, silent = true },
    },
    opts = function(_, opts)
      local extras = require("plugins.ai.codecompanion_extras.extras")
      local base_opts = {
        http = {
          timeout = 60000,  -- 60 seconds
        },
        adapters ={
          http = {
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
          }
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_tools = true,           -- Convert resources to mcp tools
              show_server_tools_in_chat = true,  -- Show mcp server tools in chat
              add_mcp_prefix_to_tool_names = true,  -- Prefix mcp tools with "mcp:" in chat
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
            show_settings = false,
            render_headers = false,
            show_header_separator = false,
            start_in_insert_mode = false,
            intro_message = "Welcome to CodeCompanion ✨! Press ? for options  │  gty YOLO mode (skip approvals)  │  gD Super Diff (review all edits)",
          },
          diff = {
            enabled = true,
            provider = "mini_diff",
            provider_opts = {
              mini_diff = {
                layout = "float",  -- Show diffs in a floating popup instead of splits
                opts = {
                  show_keymap_hints = true,  -- Show keymap hints in the winbar
                  show_dim = true,           -- Dim background behind the float
                  dim = 30,
                },
              },
            },
          },
        },
        interactions = {
          inline = {
            keymaps = {
              -- Navigate between hunks while reviewing a diff
              next_change = {
                callback = function()
                  -- mini.diff exposes goto_hunk, fall back to vim's built-in ]c
                  local ok = pcall(function()
                    require("mini.diff").goto_hunk("next")
                  end)
                  if not ok then vim.cmd("normal! ]c") end
                end,
                description = "[Diff] Next change hunk",
                index = 5,
                modes = { n = "]c" },
                opts = { nowait = true, noremap = true },
              },
              prev_change = {
                callback = function()
                  local ok = pcall(function()
                    require("mini.diff").goto_hunk("prev")
                  end)
                  if not ok then vim.cmd("normal! [c") end
                end,
                description = "[Diff] Previous change hunk",
                index = 6,
                modes = { n = "[c" },
                opts = { nowait = true, noremap = true },
              },
              -- Accept the current hunk AND write the buffer (gda can leave it dirty)
              accept_and_write = {
                callback = function(obj)
                  local inline_keymaps = require("codecompanion.interactions.inline.keymaps")
                  -- Delegate to the normal accept_change callback
                  inline_keymaps.accept_change(obj)
                  -- Then write the buffer to disk
                  vim.schedule(function()
                    local bufnr = obj and obj.diff and obj.diff.bufnr
                    if bufnr and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modified then
                      pcall(vim.api.nvim_buf_call, bufnr, function() vim.cmd("silent! write") end)
                    end
                  end)
                end,
                description = "[Diff] Accept change & write buffer",
                index = 7,
                modes = { n = "gdw" },
                opts = { nowait = true, noremap = true },
              },
            },
          },
          chat = {
            tools = {
              ["file_search"]      = extras.no_approval(),
              ["grep_search"]      = extras.no_approval(),
              ["list_code_usages"] = extras.no_approval(),
              ["get_changed_files"]= extras.no_approval(),
              ["read_file"]        = extras.no_approval(),
              -- write/destructive tools still require approval:
              -- ["insert_edit_into_file"] = extras.no_approval(),
              -- ["create_file"]  = extras.no_approval(),
              -- ["delete_file"]  = extras.no_approval(),
              -- ["cmd_runner"]   = extras.no_approval(),

              opts = { 
                default_tools = { "files", "mcp__codegraph" }
              }
            }
          }
        },
        log_level = "DEBUG"
      }

      return extras.extend_opts(base_opts)
    end
  },{
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end
  }

}
