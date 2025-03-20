if _G.lang.java == false then
  return {}
end

return {
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    config = function()
      require("java").setup()
      require("lspconfig").jdtls.setup {
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "Java-21",
                  path = "/usr/lib/jvm/java-21-openjdk-amd64",
                  default = true,
                },
              },
            },
          },
        },
      }
    end,
  },
}
