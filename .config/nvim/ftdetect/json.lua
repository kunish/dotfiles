vim.cmd [[
  autocmd BufRead,BufNewFile .prettierrc,.babelrc,.eslintrc,.eslintcache,.releaserc,.huskyrc,.lintstagedrc,.commitlintrc,.stylelintrc setlocal filetype=json
  autocmd BufRead,BufNewFile */.vscode/*.json,tsconfig.json setlocal filetype=jsonc
]]
