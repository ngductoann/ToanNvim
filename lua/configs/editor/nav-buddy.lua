return {
  opts = {
    window = {
      border = "rounded", -- "rounded", "double", "solid", "none"
      -- or an array with eight chars building up the border in a clockwise fashion
      -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
      size = { height = "30%", width = "60%" }, -- Or table format example: { height = "40%", width = "100%"}
      position = { row = "0%", col = "100%" }, -- Or table format example: { row = "100%", col = "0%"}
      scrolloff = nil, -- scrolloff value within navbuddy window
      sections = {
        left = {
          size = "20%",
          border = nil, -- You can set border style for each section individually as well.
        },
        mid = {
          size = "30%",
          border = nil,
        },
        right = {
          -- No size option for right most section. It fills to
          -- remaining area.
          border = nil,
          preview = "leaf", -- Right section can show previews too.
          -- Options: "leaf", "always" or "never"
        },
      },
    },
    icons = require("icons").kinds,
    lsp = {
      auto_attach = true, -- If set to true, you don't need to manually use attach function
      preference = nil, -- list of lsp server names in order of preference
    },
    source_buffer = {
      follow_node = true, -- Keep the current node in focus on the source buffer
      highlight = true, -- Highlight the currently focused node
      reorient = "smart", -- "smart", "top", "mid" or "none"
    },
  },
  config = function(_, opts)
    require("nvim-navbuddy").setup(opts)
    -- TODO: Find a proper way to do this with Lush
    -- Current Lush solution only provide `cleared` as result
    vim.cmd [[
          hi link NavbuddyArray         @punctuation
          hi link NavbuddyBoolean       @boolean
          hi link NavbuddyClass         @lsp.type.class
          hi link NavbuddyConstant      @constant
          hi link NavbuddyConstructor   @constructor
          hi link NavbuddyEnum          @lsp.type.enum
          hi link NavbuddyEnumMember    @lsp.type.enumMember
          hi link NavbuddyEvent         @field
          hi link NavbuddyField         @field
          hi link NavbuddyFunction      @function
          hi link NavbuddyInterface     @lsp.type.interface
          hi link NavbuddyKey           @keyword
          hi link NavbuddyMethod        @method
          hi link NavbuddyModule        @module
          hi link NavbuddyNamespace     @namespace
          hi link NavbuddyNull          @constant
          hi link NavbuddyNumber        @number
          hi link NavbuddyObject        @lsp.type.class
          hi link NavbuddyOperator      @operator
          hi link NavbuddyPackage       @namespace
          hi link NavbuddyProperty      @parameter
          hi link NavbuddyString        @string
          hi link NavbuddyStruct        @lsp.type.struct
          hi link NavbuddyTypeParameter @lsp.type.typeParameter
          hi link NavbuddyVariable      @variable
        ]]
  end,
  keys = {
    {
      "<leader>cb",
      function()
        require("nvim-navbuddy").open()
      end,
      desc = "Navbuddy",
    },
  },
}
