function cycle_action()
  line = vim.api.nvim_get_current_line()
  char = string.sub(line, 1, 1)

  if #char == 1 then
    transitions = {p = "fixup", f = "edit", e = "squash", s = "pick"}
    space_pos = string.find(line, " ")
    next = transitions[char]

    if next ~= nil then
      vim.api.nvim_set_current_line(next .. string.sub(line, space_pos))
    end
  end
end

vim.keymap.set("n", "<Cr>", cycle_action, { remap = false })
