local M = {}

function M.run_current_file()
  local filename = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype

  local cmds = {
    python = "python3 ",
    sh = "bash ",
    terraform = "terraform fmt %s && terraform apply -auto-approve",
    lua = "lua ",
    javascript = "node "
  }

  local runner = cmds[filetype]
  if not runner then
    vim.notify("Unsupported filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  local cmd = runner:format(vim.fn.shellescape(filename))

  if vim.fn.system("tmux list-panes | wc -l") == "1\n" then
    vim.fn.system("tmux split-window -v -l 15")
    vim.fn.system("sleep 0.1")
  end

  local pane = vim.fn.system("tmux list-panes -F '#{pane_id}' | tail -n1"):gsub("\n", "")
  vim.fn.system("tmux send-keys -t " .. pane .. " 'clear' C-m")
  vim.fn.system("tmux send-keys -t " .. pane .. " " .. vim.fn.shellescape(cmd) .. " C-m")
  vim.fn.system("tmux select-pane -t 0")
end

return M
