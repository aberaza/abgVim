local status, copilot = pcall(require, 'copilot')
if (not status) then return end

local useCmp, cmp_copilot = pcall(require, 'copilot_cmp')
if (useCmp) then
  copilot.setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  cmp_copilot.setup()
else 
  copilot.setup({
    suggestion = { 
      enabled = true,
      auto_trigger = false,
      hide_during_completion = true,
      debounce = 150,
      layout = {
        position = "bottom",
        ration = 0.25
      },
    },
    panel = { 
      enabled = true,
      auto_refresh = true,
      debounce = 150,
    },
    copilot_node_command = 'node', -- Node.js version must be > 18.x
  })
end
