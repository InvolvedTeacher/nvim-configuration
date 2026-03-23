-- Feline
-- [[ Target status bar:
--   mode\ \file\ \git\ .. /diagnostics(colors)/language/ /line:col'/'lines
-- ]]
local feline = require("feline")
local vi_mode = require('feline.providers.vi_mode')
local lsp = require("feline.providers.lsp")

--
-- Define constants
--

local LEFT = 1
local RIGHT = 2

local VI_MODE_COLORS = {
    ['NORMAL'] = 'green',
    ['OP'] = 'green',
    ['INSERT'] = 'red',
    ['VISUAL'] = 'skyblue',
    ['LINES'] = 'skyblue',
    ['BLOCK'] = 'skyblue',
    ['REPLACE'] = 'violet',
    ['V-REPLACE'] = 'violet',
    ['ENTER'] = 'cyan',
    ['MORE'] = 'cyan',
    ['SELECT'] = 'orange',
    ['COMMAND'] = 'green',
    ['SHELL'] = 'green',
    ['TERM'] = 'green',
    ['NONE'] = 'yellow',
}

-- Mocha theme colors
local THEME = {
    fg = '#6c7086',
    bg = '#1e1e2e',
    black = '#11111b',
    skyblue = '#89dceb',
    cyan = '#74c7ec',
    green = '#a6e3a1',
    oceanblue = '#89b4fa',
    blue = '#89b4fa',
    magenta = '#cba6f7',
    orange = '#fab387',
    red = '#f38ba8',
    violet = '#b4befe',
    white = '#cdd6f4',
    yellow = '#f9e2af',
}

--[[
-- Set up helpers
--]]

--- get the current buffer's file name, defaults to '[no name]'
local function get_filename()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename == '' then
        filename = '[no name]'
    end
    -- this is some vim magic to remove the current working directory path
    -- from the absolute path of the filename in order to make the filename
    -- relative to the current working directory
    return vim.fn.fnamemodify(filename, ':~:.')
end

--- get the current buffer's file type, defaults to '[not type]'
local function get_filetype()
    local filetype = vim.bo.filetype
    if filetype == '' then
        filetype = '[no type]'
    end
    return filetype:lower()
end

--- get the cursor's line and column
local function get_line_col_cursor()
    local cursor_line, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    return cursor_line .. ':' .. cursor_col
end

--- get the file's total number of lines
local function get_line_total()
    return vim.api.nvim_buf_line_count(0)
end

--- wrap a string with whitespaces
local function wrap(string)
    return ' ' .. string .. ' '
end

--- decorate a provider with a wrapper function
-- the provider must conform to signature: (component, opts) -> string
-- the wrapper must conform to the signature: (string) -> string
-- NOTE: Currently this is over-engineered. It is left intentionally for possible use in the future.
local function wrapped_provider(provider, wrapper)
    return function(component, opts)
        return wrapper(provider(component, opts))
    end
end

-- Diagnostics separator getters
local function get_filetype_left_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        } }) > 0) then
        return ''
    end
    return 'slant_left'
end

local function get_error_left_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        } }) > 0) then
        return ''
    end
    return 'slant_left'
end

local function get_warn_left_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        } }) > 0) then
        return ''
    end
    return 'slant_left'
end

local function get_info_left_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.HINT,
        } }) > 0) then
        return ''
    end
    return 'slant_left'
end

local function get_warn_right_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.ERROR,
        } }) > 0) then
        return {
            str = 'slant_right_2',
            hl = {
                fg = 'yellow',
                bg = 'red'
            }
        }
    end
    return {
        str = 'slant_right_2',
        hl = {
            fg = 'yellow',
            bg = 'white'
        }
    }
end

local function get_info_right_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.WARN,
        } }) > 0) then
        return {
            str = 'slant_right_2',
            hl = {
                fg = 'blue',
                bg = 'yellow'
            }
        }
    end
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.ERROR,
        } }) > 0) then
        return {
            str = 'slant_right_2',
            hl = {
                fg = 'blue',
                bg = 'red'
            }
        }
    end
    return {
        str = 'slant_right_2',
        hl = {
            fg = 'blue',
            bg = 'white'
        }
    }
end

local function get_hint_right_sep()
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.INFO,
        } }) > 0) then
        return {
            str = 'slant_right_2',
            hl = {
                fg = 'skyblue',
                bg = 'blue'
            }
        }
    end
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.WARN,
        } }) > 0) then
        return {
            str = 'slant_right_2',
            hl = {
                fg = 'skyblue',
                bg = 'yellow'
            }
        }
    end
    if (#vim.diagnostic.get(0, { severity = {
            vim.diagnostic.severity.ERROR,
        } }) > 0) then
        return {
            str = 'slant_right_2',
            hl = {
                fg = 'skyblue',
                bg = 'red'
            }
        }
    end
    return {
        str = 'slant_right_2',
        hl = {
            fg = 'skyblue',
            bg = 'white'
        }
    }
end

--[[
-- Set up custom providers
--]]

--- provide the vim mode (NOMRAL, INSERT, etc.)
local function provide_mode(component, opts)
    return vi_mode.get_vim_mode()
end

--- provide the buffer's file name
local function provide_filename(component, opts)
    return get_filename()
end

--- provide the line's information (curosor position and file's total lines)
local function provide_linenumber(component, opts)
    return get_line_col_cursor() .. '/' .. get_line_total()
end

-- provide the buffer's file type
local function provide_filetype(component, opts)
    return get_filetype()
end

--- provide only the number of diagnostic errors
local function provide_hint_count(component, opts)
    local counts = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    return #counts > 0 and tostring(#counts) or '' -- Return the count or an empty string if there are none
end

--- provide only the number of diagnostic errors
local function provide_info_count(component, opts)
    local counts = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    return #counts > 0 and tostring(#counts) or '' -- Return the count or an empty string if there are none
end

--- provide only the number of diagnostic errors
local function provide_warn_count(component, opts)
    local counts = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    return #counts > 0 and tostring(#counts) or '' -- Return the count or an empty string if there are none
end

--- provide only the number of diagnostic errors
local function provide_error_count(component, opts)
    local counts = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    return #counts > 0 and tostring(#counts) or '' -- Return the count or an empty string if there are none
end

--[[
-- Build components
--]]

local components = {
    active = {},
    inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- insert the mode component at the beginning of the left section
table.insert(components.active[LEFT], {
    name = 'mode',
    provider = wrapped_provider(provide_mode, wrap),
    right_sep = 'slant_right',
    -- hl needs to be a function to avoid calling get_mode_color
    -- before feline initiation
    hl = function()
        return {
            fg = 'black',
            bg = vi_mode.get_mode_color(),
        }
    end,
})

-- insert the filename component after the mode component
table.insert(components.active[LEFT], {
    name = 'filename',
    provider = wrapped_provider(provide_filename, wrap),
    left_sep = 'slant_left_2',
    right_sep = 'slant_right',
    hl = {
        bg = 'white',
        fg = 'black',
    },
})

-- insert git information
table.insert(components.active[LEFT], {
    name = 'git-branch',
    provider = 'git_branch',
    left_sep = ' ',
    hl = {
        fg = 'white'
    },
})

table.insert(components.active[LEFT], {
    name = 'git-added',
    provider = 'git_diff_added',
    icon = {
        str = ' 󰜄 ',
        hl = { fg = 'green' },
    },
    left_sep = ' ',
    hl = {
        fg = 'green',
    },
})

table.insert(components.active[LEFT], {
    name = 'git-changed',
    provider = 'git_diff_changed',
    icon = {
        str = ' 󱗝 ',
        hl = { fg = 'orange' },
    },
    left_sep = ' ',
    hl = {
        fg = 'orange',
    },
})

table.insert(components.active[LEFT], {
    name = 'git-removed',
    provider = 'git_diff_removed',
    icon = {
        str = ' 󰛲 ',
        hl = { fg = 'red' },
    },
    left_sep = ' ',
    hl = {
        fg = 'red',
    },
})

table.insert(components.active[RIGHT], {
    name = 'diagnostic_hints',
    provider = wrapped_provider(provide_hint_count, wrap),
    left_sep = 'slant_left',
    right_sep = function()
        return get_hint_right_sep()
    end,
    enabled = function()
        return lsp.diagnostics_exist('Hint')
    end,
    hl = {
        fg = 'black',
        bg = 'skyblue',
    },
})

table.insert(components.active[RIGHT], {
    name = 'diagnostic_info',
    provider = wrapped_provider(provide_info_count, wrap),
    left_sep = function()
        return get_info_left_sep()
    end,
    right_sep = function()
        return get_info_right_sep()
    end,
    enabled = function()
        return lsp.diagnostics_exist('Info')
    end,
    hl = {
        fg = 'black',
        bg = 'blue',
    },
})

table.insert(components.active[RIGHT], {
    name = 'diagnostic_warnings',
    provider = wrapped_provider(provide_warn_count, wrap),
    left_sep = function()
        return get_warn_left_sep()
    end,
    right_sep = function()
        return get_warn_right_sep()
    end,
    enabled = function()
        return lsp.diagnostics_exist('Warn')
    end,
    hl = {
        fg = 'black',
        bg = 'yellow',
    },
})

table.insert(components.active[RIGHT], {
    name = 'diagnostic_errors',
    provider = wrapped_provider(provide_error_count, wrap),
    left_sep = function()
        return get_error_left_sep()
    end,
    right_sep = {
        str = 'slant_right_2',
        hl = { fg = 'red', bg = 'white' }
    },
    enabled = function()
        return lsp.diagnostics_exist('Error')
    end,
    hl = {
        fg = 'black',
        bg = 'red',
    },
})

-- insert the filetype component before the linenumber component
table.insert(components.active[RIGHT], {
    name = 'filetype',
    provider = wrapped_provider(provide_filetype, wrap),
    left_sep = function()
        return get_filetype_left_sep()
    end,
    right_sep = 'slant_right_2',
    hl = {
        bg = 'white',
        fg = 'black',
    },
})

-- insert the linenumber component at the end of the left right section
table.insert(components.active[RIGHT], {
    name = 'linenumber',
    provider = wrapped_provider(provide_linenumber, wrap),
    left_sep = 'slant_left',
    hl = {
        bg = 'skyblue',
        fg = 'black',
    },
})

-- insert the inactive filename component at the beginning of the left section
table.insert(components.inactive[LEFT], {
    name = 'filename_inactive',
    provider = wrapped_provider(provide_filename, wrap),
    right_sep = 'slant_right',
    hl = {
        fg = 'white',
        bg = 'bg',
    },
})

feline.setup({
    theme = THEME,
    components = components,
    vi_mode_colors = VI_MODE_COLORS,
})
