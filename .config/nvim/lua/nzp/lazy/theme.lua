-- function apply(color)
-- 	color = color or "catppuccin"
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

return { 
  "folke/tokyonight.nvim", 
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night"
    })
    vim.cmd.colorscheme "tokyonight"
  end,
}
