local M = {}

local terminal_buffer
local terminal_window
local terminal_job

local function project_root(path)
  local git_dir = vim.fs.root(path, { ".git" })
  return git_dir or vim.fs.dirname(path)
end

local function close_window()
  if terminal_window and vim.api.nvim_win_is_valid(terminal_window) then
    vim.api.nvim_win_close(terminal_window, true)
  end
  terminal_window = nil
end

local function open_window(buffer)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)

  terminal_window = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    title = " Terminal ",
    title_pos = "center",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
  })
end

local function start_terminal(command, cwd)
  close_window()

  if terminal_job then
    vim.fn.jobstop(terminal_job)
  end

  terminal_buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[terminal_buffer].bufhidden = "hide"
  open_window(terminal_buffer)

  terminal_job = vim.fn.termopen(command or vim.o.shell, {
    cwd = cwd,
    on_exit = function()
      terminal_job = nil
    end,
  })

  vim.cmd.startinsert()
end

function M.toggle()
  if terminal_window and vim.api.nvim_win_is_valid(terminal_window) then
    close_window()
    return
  end

  if terminal_buffer and vim.api.nvim_buf_is_valid(terminal_buffer) then
    open_window(terminal_buffer)
    vim.cmd.startinsert()
  else
    start_terminal()
  end
end

function M.run_cpp()
  local source = vim.api.nvim_buf_get_name(0)
  if source == "" then
    vim.notify("Save the C++ file before compiling it.", vim.log.levels.WARN)
    return
  end

  local extension = vim.fn.fnamemodify(source, ":e")
  if extension ~= "cpp" and extension ~= "cc" and extension ~= "cxx" then
    vim.notify("CppRun only supports .cpp, .cc, and .cxx files.", vim.log.levels.WARN)
    return
  end

  if vim.bo.modified then
    vim.cmd.write()
  end

  local root = project_root(source)
  local build_dir = root .. "/build"
  local executable = build_dir .. "/" .. vim.fn.fnamemodify(source, ":t:r")
  vim.fn.mkdir(build_dir, "p")

  local command = table.concat({
    "c++ -std=c++23 -Wall -Wextra -Wpedantic -g",
    vim.fn.shellescape(source),
    "-o",
    vim.fn.shellescape(executable),
    "&&",
    vim.fn.shellescape(executable),
  }, " ")

  start_terminal({ vim.o.shell, "-c", command }, root)
end

function M.setup()
  vim.api.nvim_create_user_command("FloatTerm", M.toggle, { desc = "Toggle floating terminal" })
  vim.api.nvim_create_user_command("CppRun", M.run_cpp, { desc = "Compile and run current C++ file" })

  vim.keymap.set("n", "<leader>tt", M.toggle, { desc = "Toggle floating terminal" })
  vim.keymap.set("n", "<leader>cr", M.run_cpp, { desc = "Compile and run C++ file" })
  vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
end

return M
