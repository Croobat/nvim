-- :help options

o = vim.opt

local options = {
  backup = false,                           -- creates a backup file
  clipboard = "unnamedplus",                -- allows neovim to access the system clipboard
  cmdheight = 1,                            -- space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" },  -- mostly just for cmp
  conceallevel = 0,                         -- `` visible md files
  fileencoding = "utf-8",                   -- the encoding written to a file
  hlsearch = false,                         -- highlight matches prev search
  ignorecase = true,                        -- ignore case in search patterns
  mouse = "a",                              -- allow mouse
  pumheight = 10,                           -- smaller pop up menu height
  showmode = false,                         --  -- INSERT --
  showtabline = 1,                          -- show tabs if >=2
  smartcase = true,                         -- smart case
  smartindent = true,                       -- make indenting smarter again
  autoindent = true,
  splitbelow = true,                        -- horizontal splits to go below current window
  splitright = true,                        -- vertical splits to go to the right of current window
  swapfile = false,                         -- creates a swapfile
  termguicolors = true,                     -- set term gui colors
  timeoutlen = 200,                         -- time to wait for a mapped sequence to complete
  undofile = true,                          -- disable persistent undo
  updatetime = 200,                         -- faster completion (4000ms default)
  writebackup = false,                      -- if a file is being edited it cant be edited at same time
  expandtab = false,                         -- convert tabs to spaces
  shiftwidth = 4,                           -- the number of spaces inserted for each indentation
  tabstop = 4,                              -- insert spaces for a tab
  cursorline = true,                        -- highlight the current line
  number = true,                            -- set numbered lines
  relativenumber = false,                   -- set relative numbered lines
  numberwidth = 2,                          -- set number column width to 2 {default 4}
  signcolumn = "yes",                       -- always show the sign colum
  wrap = false,                             -- display lines as one long line
  lisp = true,                              -- indentation when line break
  scrolloff = 8,                            -- minimum distance cursor-border
  sidescrolloff = 0,
  guifont = "JetBrainsMono Nerd Font:h13",  -- the font used in graphical neovim applications
  foldmethod = "marker",                           -- Marker fold method {}
  wildmode = "longest,full",                -- Better tab completion
  textwidth = 79                             -- text width
}

for k, v in pairs(options) do               -- abreviando vim.opt.x con local options y o
  o[k] = v
end

o.shm:append "TIc"                          -- Disable start screen, truncate long msg, dont give ins-completion menu
o.list.lcs = "tab:|"

vim.cmd "set whichwrap+=<,>,[,],h,l"        -- Keys that move to next wrapped line
vim.cmd "set iskeyword+=^-,^_"              -- New word delimitators
vim.cmd "autocmd BufEnter * set formatoptions-=o" -- Disable auto comment new line
