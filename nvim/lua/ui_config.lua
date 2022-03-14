require('lualine').setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_c = {'buffers'},
    lualine_x = {'filetype'},
  }
}
