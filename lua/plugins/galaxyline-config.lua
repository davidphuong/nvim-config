local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
    return
end

local gls = gl.section

gl.short_line_list = {" "}

vim.g.status_theme = "onedark"
local global_theme = "themes/" .. vim.g.status_theme
local colors = require(global_theme)

gls.left[1] = {
    FirstElement = {
        provider = function()
            return "▋"
        end,
        highlight = {colors.nord_blue, colors.nord_blue}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "  "
        end,
        highlight = {colors.statusline_bg, colors.nord_blue},
        separator = "  ",
        separator_highlight = {colors.nord_blue, colors.lightbg}
    }
}

gls.left[3] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.grey_fg2, colors.lightbg2},
        separator = " ",
        separator_highlight = {colors.lightbg2, colors.statusline_bg}
    }
}

gls.left[4] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg}
    }
}

gls.left[5] = {
    FileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.white, colors.statusline_bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " 柳 ",
        -- highlight = {colors.grey_fg2, colors.statusline_bg}
        -- highlight = {colors.grey_fg2, colors.statusline_bg}
        highlight = { colors.blue, colors.statusline_bg },
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.red, colors.statusline_bg}
    }
}

gls.left[9] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.statusline_bg}
    }
}

gls.left[10] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.statusline_bg}
    }
}

local get_lsp_client = function(msg)
  msg = msg or "LSP Inactive"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  local lsps = ""
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      -- print(client.name)
      if lsps == "" then
        -- print("first", lsps)
        lsps = client.name
      else
        if not string.find(lsps, client.name) then
          lsps = lsps .. ", " .. client.name
        end
        -- print("more", lsps)
      end
    end
  end
  if lsps == "" then
    return msg
  else
    return lsps
  end
end

gls.right[1] = {
    lsp_status = {
    provider = get_lsp_client,
    condition = function()
      local tbl = { ["dashboard"] = true, [" "] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = " ",
    highlight = { colors.grey, colors.alt_bg },
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.grey_fg2, colors.statusline_bg},
        separator = " ",
        separator_highlight = {colors.statusline_bg, colors.statusline_bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.right[4] = {
    viMode_icon = {
        provider = function()
            return " "
        end,
        highlight = {colors.statusline_bg, colors.red},
        separator = " ",
        separator_highlight = {colors.red, colors.statusline_bg}
    }
}

gls.right[5] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "Normal",
                i = "Insert",
                c = "Command",
                V = "Visual",
                [""] = "Visual",
                v = "Visual",
                R = "Replace"
            }
            local current_Mode = alias[vim.fn.mode()]

            if current_Mode == nil then
                return "  Terminal "
            else
                return "  " .. current_Mode .. " "
            end
        end,
        highlight = {colors.red, colors.lightbg}
    }
}

gls.right[6] = {
    some_icon = {
        provider = function()
            return " "
        end,
        separator = "",
        separator_highlight = {colors.green, colors.lightbg},
        highlight = {colors.lightbg, colors.green}
    }
}

gls.right[7] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return "  Top "
            elseif current_line == vim.fn.line("$") then
                return "  Bot "
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return "  " .. result .. "% "
        end,
        highlight = {colors.green, colors.lightbg}
    }
}

























































-- -- if not package.loaded['galaxyline'] then
-- --   return
-- -- end

-- local blah = {
--     alt_bg = "#2E2E2E",
--     grey = "#858585",
--     blue = "#569CD6",
--     green = "#608B4E",
--     yellow = "#DCDCAA",
--     orange = "#FF8800",
--     purple = "#C586C0",
--     magenta = "#D16D9E",
--     cyan = "#4EC9B0",
--     red = "#D16969",
--     error_red = "#F44747",
--     warning_orange = "#FF8800",
--     info_yellow = "#FFCC66",
--     hint_blue = "#9CDCFE",
-- }

-- local status_ok, gl = pcall(require, "galaxyline")
-- if not status_ok then
--   return
-- end

-- -- NOTE: if someone defines colors but doesn't have them then this will break
-- colors = blah

-- local condition = require "galaxyline.condition"
-- local gls = gl.section
-- gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

-- table.insert(gls.left, {
--   ViMode = {
--     provider = function()
--       -- auto change color according the vim mode
--       local mode_color = {
--         n = colors.blue,
--         i = colors.green,
--         v = colors.purple,
--         [""] = colors.purple,
--         V = colors.purple,
--         c = colors.magenta,
--         no = colors.blue,
--         s = colors.orange,
--         S = colors.orange,
--         [""] = colors.orange,
--         ic = colors.yellow,
--         R = colors.red,
--         Rv = colors.red,
--         cv = colors.blue,
--         ce = colors.blue,
--         r = colors.cyan,
--         rm = colors.cyan,
--         ["r?"] = colors.cyan,
--         ["!"] = colors.blue,
--         t = colors.blue,
--       }
--       vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
--       return "▊"
--     end,
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { "NONE", colors.alt_bg },
--   },
-- })
-- -- print(vim.fn.getbufvar(0, 'ts'))
-- vim.fn.getbufvar(0, "ts")

-- table.insert(gls.left, {
--   GitIcon = {
--     provider = function()
--       return "  "
--     end,
--     condition = condition.check_git_workspace,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.orange, colors.alt_bg },
--   },
-- })

-- table.insert(gls.left, {
--   GitBranch = {
--     provider = "GitBranch",
--     condition = condition.check_git_workspace,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.left, {
--   DiffAdd = {
--     provider = "DiffAdd",
--     condition = condition.hide_in_width,
--     icon = "  ",
--     highlight = { colors.green, colors.alt_bg },
--   },
-- })

-- table.insert(gls.left, {
--   DiffModified = {
--     provider = "DiffModified",
--     condition = condition.hide_in_width,
--     icon = " 柳",
--     highlight = { colors.blue, colors.alt_bg },
--   },
-- })

-- table.insert(gls.left, {
--   DiffRemove = {
--     provider = "DiffRemove",
--     condition = condition.hide_in_width,
--     icon = "  ",
--     highlight = { colors.red, colors.alt_bg },
--   },
-- })

-- table.insert(gls.left, {
--   Filler = {
--     provider = function()
--       return " "
--     end,
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })
-- -- get output from shell command
-- function os.capture(cmd, raw)
--   local f = assert(io.popen(cmd, "r"))
--   local s = assert(f:read "*a")
--   f:close()
--   if raw then
--     return s
--   end
--   s = string.gsub(s, "^%s+", "")
--   s = string.gsub(s, "%s+$", "")
--   s = string.gsub(s, "[\n\r]+", " ")
--   return s
-- end
-- -- cleanup virtual env
-- local function env_cleanup(venv)
--   if string.find(venv, "/") then
--     local final_venv = venv
--     for w in venv:gmatch "([^/]+)" do
--       final_venv = w
--     end
--     venv = final_venv
--   end
--   return venv
-- end
-- local PythonEnv = function()
--   if vim.bo.filetype == "python" then
--     local venv = os.getenv "CONDA_DEFAULT_ENV"
--     if venv ~= nil then
--       return "  (" .. env_cleanup(venv) .. ")"
--     end
--     venv = os.getenv "VIRTUAL_ENV"
--     if venv ~= nil then
--       return "  (" .. env_cleanup(venv) .. ")"
--     end
--     return ""
--   end
--   return ""
-- end
-- table.insert(gls.left, {
--   VirtualEnv = {
--     provider = PythonEnv,
--     event = "BufEnter",
--     highlight = { colors.green, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   DiagnosticError = {
--     provider = "DiagnosticError",
--     icon = "  ",
--     highlight = { colors.red, colors.alt_bg },
--   },
-- })
-- table.insert(gls.right, {
--   DiagnosticWarn = {
--     provider = "DiagnosticWarn",
--     icon = "  ",
--     highlight = { colors.orange, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   DiagnosticInfo = {
--     provider = "DiagnosticInfo",
--     icon = "  ",
--     highlight = { colors.yellow, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   DiagnosticHint = {
--     provider = "DiagnosticHint",
--     icon = "  ",
--     highlight = { colors.blue, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   TreesitterIcon = {
--     provider = function()
--       if next(vim.treesitter.highlighter.active) ~= nil then
--         return "  "
--       end
--       return ""
--     end,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.green, colors.alt_bg },
--   },
-- })

-- local get_lsp_client = function(msg)
--   msg = msg or "LSP Inactive"
--   local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--   local clients = vim.lsp.get_active_clients()
--   if next(clients) == nil then
--     return msg
--   end
--   local lsps = ""
--   for _, client in ipairs(clients) do
--     local filetypes = client.config.filetypes
--     if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--       -- print(client.name)
--       if lsps == "" then
--         -- print("first", lsps)
--         lsps = client.name
--       else
--         if not string.find(lsps, client.name) then
--           lsps = lsps .. ", " .. client.name
--         end
--         -- print("more", lsps)
--       end
--     end
--   end
--   if lsps == "" then
--     return msg
--   else
--     return lsps
--   end
-- end

-- table.insert(gls.right, {
--   ShowLspClient = {
--     provider = get_lsp_client,
--     condition = function()
--       local tbl = { ["dashboard"] = true, [" "] = true }
--       if tbl[vim.bo.filetype] then
--         return false
--       end
--       return true
--     end,
--     icon = " ",
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   LineInfo = {
--     provider = "LineColumn",
--     separator = "  ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   PerCent = {
--     provider = "LinePercent",
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   Tabstop = {
--     provider = function()
--       return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
--     end,
--     condition = condition.hide_in_width,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   BufferType = {
--     provider = "FileTypeName",
--     condition = condition.hide_in_width,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   FileEncode = {
--     provider = "FileEncode",
--     condition = condition.hide_in_width,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.right, {
--   Space = {
--     provider = function()
--       return " "
--     end,
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.grey, colors.alt_bg },
--   },
-- })

-- table.insert(gls.short_line_left, {
--   BufferType = {
--     provider = "FileTypeName",
--     separator = " ",
--     separator_highlight = { "NONE", colors.alt_bg },
--     highlight = { colors.alt_bg, colors.alt_bg },
--   },
-- })

-- table.insert(gls.short_line_left, {
--   SFileName = {
--     provider = "SFileName",
--     condition = condition.buffer_not_empty,
--     highlight = { colors.alt_bg, colors.alt_bg },
--   },
-- })

-- --table.insert(gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.alt_bg}}})

