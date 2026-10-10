-- 📝 Auto-save & Beginner-friendly Neovim config for Scratchpad Notes
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.signcolumn = 'yes'

-- Auto-save on text change, focus lost, and buffer leave
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "FocusLost", "BufLeave", "VimLeavePre" }, {
    pattern = "*",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
            vim.cmd("silent! wall")
        end
    end,
})

-- Shortcut Ctrl+S for instant manual save in all modes
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
    vim.cmd("silent! wall")
end, { desc = "Save file" })

-- Helpful statusline with beginner cheat sheet
vim.opt.statusline = " 📝 %f %m %= %y | [i] Ketik | [Esc] Normal | [u] Undo | [Ctrl+S] Simpan | [:q] Keluar  %l:%c "
