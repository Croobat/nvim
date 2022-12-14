-- Setup auto-pairs{{{
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}--}}}

-- Setup cmp integration{{{
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })--}}}

-- ╭──────────────╮
-- │ Custom rules │
-- ╰──────────────╯
local Rule = require'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'

npairs.add_rules {
-- Auto space
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']'),

  -- Arrow function (js)
  -- Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' })
  --       :use_regex(true)
  --       :set_end_pair_length(2),

  -- space on equal
  -- Rule('=', '')
  -- :with_pair(cond.not_inside_quote())
  -- :with_pair(function(opts)
  --     local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
  --     if last_char:match('[%w%=%s]') then
  --         return true
  --     end
  --     return false
  -- end)
  -- :replace_endpair(function(opts)
  --     local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
  --     local next_char = opts.line:sub(opts.col, opts.col)
  --     next_char = next_char == ' ' and '' or ' '
  --     if prev_2char:match('%w$') then
  --         return '<bs> =' .. next_char
  --     end
  --     if prev_2char:match('%=$') then
  --         return next_char
  --     end
  --     if prev_2char:match('=') then
  --         return '<bs><bs>=' .. next_char
  --     end
  --     return ''
  -- end)
  -- :set_end_pair_length(0)
  -- :with_move(cond.none())
  -- :with_del(cond.none())
}
