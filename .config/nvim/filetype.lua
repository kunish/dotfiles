vim.filetype.add({
  extension = {
    mdx = 'markdown',
    tf = 'terraform',
  },
  filename = {
    ['.eslintcache'] = 'json',
    ['.releaserc'] = 'json',
  },
})
