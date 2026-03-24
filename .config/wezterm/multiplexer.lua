-- multiplexer.lua
-- Replaces tmux: sessions (workspaces), windows (tabs), panes, and status bar.
-- Usage: require('multiplexer').apply(config) from wezterm.lua

local wezterm = require 'wezterm'
local act = wezterm.action
local M = {}

function M.apply(config)
  -- Leader key: Ctrl-A (like tmux prefix)
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

  -- --- Tab bar (replaces tmux status bar)
  config.enable_tab_bar = true
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.show_tab_index_in_tab_bar = false
  config.tab_max_width = 32

  -- --- Keybindings
  local keys = {
    -- Sessions (workspaces): Alt-n / Alt-p to cycle
    { key = 'n', mods = 'ALT', action = act.SwitchWorkspaceRelative(1) },
    { key = 'p', mods = 'ALT', action = act.SwitchWorkspaceRelative(-1) },

    -- New workspace: Leader w (like tmux :new)
    {
      key = 'w',
      mods = 'LEADER',
      action = act.PromptInputLine {
        description = 'Enter name for new workspace',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:perform_action(act.SwitchToWorkspace { name = line }, pane)
          end
        end),
      },
    },

    -- Session switcher: Leader s (popup workspace list)
    {
      key = 's',
      mods = 'LEADER',
      action = act.ShowLauncherArgs { title = 'Workspaces', flags = 'FUZZY|WORKSPACES' },
    },

    -- Windows (tabs): Alt-1..9 to select
    { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = act.ActivateTab(8) },

    -- Leader Ctrl-A: last tab (like tmux last-window)
    { key = 'a', mods = 'LEADER|CTRL', action = act.ActivateLastTab },

    -- Leader n/p: next/prev tab
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

    -- New tab: Leader c
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },

    -- Splits: Leader - (vertical), Leader | (horizontal)
    { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    -- Pane navigation: Leader h/j/k/l
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

    -- Pane resize: Leader H/J/K/L
    { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Left', 10 } },
    { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Down', 10 } },
    { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Up', 10 } },
    { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Right', 10 } },

    -- Pane swap: Leader Alt-j / Leader Alt-k
    { key = 'j', mods = 'LEADER|ALT', action = act.RotatePanes 'Clockwise' },
    { key = 'k', mods = 'LEADER|ALT', action = act.RotatePanes 'CounterClockwise' },

    -- Close pane: Leader x
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

    -- Copy mode (vi-style): Leader [
    { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  }

  -- Merge with any existing keys in config
  if config.keys then
    for _, k in ipairs(keys) do
      table.insert(config.keys, k)
    end
  else
    config.keys = keys
  end
end

-- --- Status bar events (registered once on require)

-- Left: user@host | Right: workspace name
wezterm.on('update-status', function(window, _pane)
  local palette = window:effective_config().resolved_palette
  local fg = palette.foreground
  local bg = palette.background
  local user = os.getenv 'USER' or ''
  local host = wezterm.hostname()
  local workspace = window:active_workspace()

  window:set_left_status(wezterm.format {
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = ' ' .. user .. '@' .. host .. ' ' },
  })

  window:set_right_status(wezterm.format {
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = workspace .. ' ' },
  })
end)

-- Tab title: "index name" with 1-based indexing
wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, _hover, _max_width)
  local index = tab.tab_index + 1
  local title = tab.active_pane.title
  if title == '' then
    title = tab.active_pane.foreground_process_name:match '[^/]+$' or ''
  end
  return ' ' .. index .. ' ' .. title .. ' '
end)

return M
