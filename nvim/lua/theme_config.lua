-- Theme switching module that automatically detects system theme
local M = {}

local DEFAULT_THEME = "light"

local CONFIG = {
    themes = {
        light = {
            background = "light",
            colorscheme = "gruvbox",
        },
        dark = {
            background = "dark",
            colorscheme = "gruvbox",
        }
    }
}

local current_theme = nil

local function get_system_theme()
    local handle = io.popen('SystemThemeChecker')
    if not handle then
        print("Warning: SystemThemeChecker not found, defaulting to " .. DEFAULT_THEME .. " theme")
        return DEFAULT_THEME
    end

    local result = handle:read("*a")
    handle:close()

    if result then
        result = result:gsub("%s+", "") -- trim whitespace
        if result == "dark" or result == "light" then
            return result
        end
    end

    print("Warning: Unexpected output from SystemThemeChecker, defaulting to " .. DEFAULT_THEME .. " theme")
    return DEFAULT_THEME
end

function M.apply_system_theme(silent_if_unchanged)
    local theme = get_system_theme()
    M.set_theme(theme, silent_if_unchanged and (theme == current_theme or current_theme == nil))
end

function M.toggle_theme()
    local current = vim.opt.background:get()
    local new_theme = current == "light" and "dark" or "light"
    M.set_theme(new_theme, false)
end

function M.get_available_themes()
    local available = {}
    for k, _ in pairs(CONFIG.themes) do
        table.insert(available, k)
    end
    return available
end

function M.set_theme(theme, silent)
    local theme_config = CONFIG.themes[theme]

    if not theme_config then
        local available = M.get_available_themes()
        print("Invalid theme: " .. theme .. ". Available themes: " .. table.concat(available, ", "))
        return
    end

    vim.opt.background = theme_config.background
    vim.cmd("colorscheme " .. theme_config.colorscheme)
    if not silent then
        print("Set theme to: " ..
            theme ..
            " (background=" .. theme_config.background .. ", colorscheme=" .. theme_config.colorscheme .. ")")
    end

    require('lualine').setup({
        theme = theme_config.lualine_theme or "auto"
    })

    current_theme = theme
end

function M.setup()
    local augroup = vim.api.nvim_create_augroup("ThemeChecker", { clear = true })

    -- Check theme when Neovim gains focus
    vim.api.nvim_create_autocmd("FocusGained", {
        group = augroup,
        callback = function()
            M.apply_system_theme(true)
        end,
        desc = "Update theme when Neovim gains focus"
    })

    -- Check theme when vim starts
    vim.api.nvim_create_autocmd("VimEnter", {
        group = augroup,
        callback = function()
            M.apply_system_theme(true)
        end,
        desc = "Set theme on startup"
    })

    local wk = require("which-key")
    wk.add({
        { "<leader>u",  group = "UI" },
        { "<leader>ut", M.toggle_theme,       desc = "Toggle theme" },
        { "<leader>uT", M.apply_system_theme, desc = "Switch theme" },
    })
end

vim.api.nvim_create_user_command("ThemeSync", function()
    M.apply_system_theme(false)
end, {
    desc = "Sync theme with system setting"
})

vim.api.nvim_create_user_command("ThemeToggle", M.toggle_theme, {
    desc = "Toggle between light and dark theme"
})

vim.api.nvim_create_user_command("ThemeSet", function(opts)
    M.set_theme(opts.args, false)
end, {
    nargs = 1,
    complete = function()
        return M.get_available_themes()
    end,
    desc = "Set theme to light or dark"
})

M.setup()

return M
