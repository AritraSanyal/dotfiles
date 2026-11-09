---@diagnostic disable:undefined-global
return {
  'd2lang/d2-vim',
  ft = 'd2',
  init = function()
    -- Automatically format d2 on save
    vim.g.d2_fmt_autosave = 1

    -- Render diagram as ASCII text on save
    vim.g.d2_ascii_autorender = 1
  end,
}
