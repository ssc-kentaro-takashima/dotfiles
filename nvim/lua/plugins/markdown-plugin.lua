return {
  {
    'jakewvincent/mkdnflow.nvim',
    ft = { 'markdown', 'rmd' },
    config = function()
        require('mkdnflow').setup({
            -- Your config
          links = {
            implicit_extension = "md",
          },
          modules = {
            bib = true,
            buffers = true,
            conceal = true,
            cursor = true,
            folds = true,
            foldtext = true,
            links = true,
            lists = true,
            maps = true,
            paths = true,
            tables = true,
            to_do = true,
            yaml = false,
            cmp = false,
            notebook = true,
          },
        })
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { },
    opts = {},
  }
}
