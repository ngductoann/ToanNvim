return {
  init = function()
    vim.g.navic_silence = true
    utils.lsp.on_attach(function(client, buffer)
      if client.supports_method "textDocument/documentSymbol" then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = function()
    local function set_navic_colors()
      local hl = vim.api.nvim_set_hl

      hl(0, "NavicText", { fg = "#b5b3aa", bg = "NONE" }) -- base05
      hl(0, "NavicSeparator", { fg = "#6c6c66", bg = "NONE" }) -- base03 (gray)
      hl(0, "NavicIconsFile", { fg = "#ff6c60" }) -- base08
      hl(0, "NavicIconsModule", { fg = "#ff73fd" }) -- base0E
      hl(0, "NavicIconsNamespace", { fg = "#ff73fd" }) -- base0E
      hl(0, "NavicIconsPackage", { fg = "#b18a3d" }) -- base0F
      hl(0, "NavicIconsClass", { fg = "#ffffb6" }) -- base0A
      hl(0, "NavicIconsMethod", { fg = "#96cbfe" }) -- base0D
      hl(0, "NavicIconsProperty", { fg = "#a8ff60" }) -- base0B
      hl(0, "NavicIconsField", { fg = "#ff6c60" }) -- base08
      hl(0, "NavicIconsConstructor", { fg = "#96cbfe" }) -- base0D
      hl(0, "NavicIconsEnum", { fg = "#ffffb6" }) -- base0A
      hl(0, "NavicIconsInterface", { fg = "#ff73fd" }) -- base0E
      hl(0, "NavicIconsFunction", { fg = "#96cbfe" }) -- base0D
      hl(0, "NavicIconsVariable", { fg = "#ff6c60" }) -- base08
      hl(0, "NavicIconsConstant", { fg = "#e9c062" }) -- base09
      hl(0, "NavicIconsString", { fg = "#a8ff60" }) -- base0B
      hl(0, "NavicIconsNumber", { fg = "#e9c062" }) -- base09
      hl(0, "NavicIconsBoolean", { fg = "#e9c062" }) -- base09
      hl(0, "NavicIconsArray", { fg = "#c6c5fe" }) -- base0C
      hl(0, "NavicIconsObject", { fg = "#c6c5fe" }) -- base0C
      hl(0, "NavicIconsKey", { fg = "#e9c062" }) -- base09
      hl(0, "NavicIconsNull", { fg = "#6c6c66" }) -- base03
      hl(0, "NavicIconsEnumMember", { fg = "#ffffb6" }) -- base0A
      hl(0, "NavicIconsStruct", { fg = "#ffffb6" }) -- base0A
      hl(0, "NavicIconsEvent", { fg = "#ff73fd" }) -- base0E
      hl(0, "NavicIconsOperator", { fg = "#ff6c60" }) -- base08
      hl(0, "NavicIconsTypeParameter", { fg = "#ff73fd" }) -- base0E
    end

    -- Call on startup or on ColorScheme
    set_navic_colors()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_navic_colors,
    })
    return {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      icons = require("icons").kinds,
      lazy_update_context = true,
    }
  end,
}
