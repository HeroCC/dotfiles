set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" use treesitter for folds
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99 " default all folds open

lua << EOF
require'nvim-treesitter'.setup{
  ensure_installed = { "yaml", "vimdoc", "markdown", "markdown_inline" },
  auto_install = true,
  highlight={
    enable=true
  },
}
EOF
