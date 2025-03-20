return {
    'nvimdev/dashboard-nvim',

    -- event = 'VimEnter',
    --
    config = function()
        local logo = [[
    ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗███████╗
    ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝██╔════╝
    ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║   ███████╗
    ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║   ╚════██║
    ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║   ███████║
    ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝
    ]]
        logo = string.rep("\n", 8) .. logo .. "\n\n"
        -- Function to read and load projects

        -- RECENT PROJECTS
        require('dashboard').setup {
            theme = 'hyper',
            hide = {
                statusline = false,
            },

            config = {

                header = vim.split(logo,"\n"),
                
                mru = { enable = false },
                packages = { enable = false},
                footer = {}
                -- footer = function()
                --   local stats = require("lazy").stats()
                --   local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                --   return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                -- end,
            },
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'},         { 'nvim-telescope/telescope.nvim' },

    }
}


-- return {
--     'nvimdev/dashboard-nvim',
--
--     -- event = 'VimEnter',
--     --
--     config = function()
--         local logo = [[
--     ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗███████╗
--     ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝██╔════╝
--     ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║   ███████╗
--     ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║   ╚════██║
--     ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║   ███████║
--     ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝
--     ]]
--         logo = string.rep("\n", 8) .. logo .. "\n\n"
--         -- Function to read and load projects
--         local utils = require('daykoo.dashboard_utils')
--
--         local function project_list(config, callback)
--             config.project = vim.tbl_extend('force', {
--                 limit = 8,
--                 enable = true,
--                 icon = '󰏓 ',
--                 icon_hl = 'DashboardRecentProjectIcon',
--                 action = 'Telescope find_files cwd=',
--                 label = ' Recent Projects:',
--             }, config.project or {})
--
--             local function read_project(data)
--                 local res = {}
--                 data = string.gsub(data, '%z', '')
--                 local dump = assert(loadstring(data))
--                 local list = dump()
--                 if list then
--                     list = vim.list_slice(list, #list - config.project.limit)
--                 end
--                 for _, dir in ipairs(list or {}) do
--                     dir = dir:gsub(vim.env.HOME, '~')
--                     table.insert(res, (' '):rep(3) .. ' ' .. dir)
--                 end
--
--                 if #res == 0 then
--                     table.insert(res, (' '):rep(3) .. ' empty project')
--                 else
--                     res = vim.fn.reverse(res)
--                 end
--
--                 table.insert(res, 1, config.project.icon .. config.project.label)
--                 table.insert(res, 1, '')
--                 table.insert(res, '')
--                 return res
--             end
--
--             utils.async_read(
--                 config.path,
--                 vim.schedule_wrap(function(data)
--                     local res = {}
--                     if config.project.enable then
--                         res = read_project(data)
--                     end
--                     callback(res)
--                 end)
--             )
--         end
--         
--       -- Load recent projects
--         local config_path = vim.fn.stdpath('data') .. '/dashboard/recent_projects'
--         local recent_projects = project_list({ path = config_path })
--
--         -- RECENT PROJECTS
--         require('dashboard').setup {
--             theme = 'doom',
--             hide = {
--                 statusline = false,
--             },
--
--             config = {
--
--                 header = vim.split(logo,"\n"),
--                 center = {
--                 -- recent_projects,
--                     { action = 'Telescope find_files cwd=', desc = "DESC", icon = '󰏓 ', icon_hl = 'DashboardRecentProjectIcon', label = ' Recent Projects: '},
--
--                     { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
--                     { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
--                 },
--                 footer = {}
--                 -- footer = function()
--                 --   local stats = require("lazy").stats()
--                 --   local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--                 --   return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
--                 -- end,
--             },
--         }
--     end,
--     dependencies = { {'nvim-tree/nvim-web-devicons'},         { 'nvim-telescope/telescope.nvim' },
--
--     }
-- }
