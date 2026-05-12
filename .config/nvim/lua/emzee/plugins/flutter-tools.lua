require("flutter-tools").setup()

vim.keymap.set(
  "n",
  "<leader>tf",
  function() require('telescope').extensions.flutter.commands() end,
  { desc = "Telescope flutter-tools" }
);

require('flutter-tools').setup_project({
  {
    name = 'gemini-dev',
    dart_define = { GEMINI_KEY = "AIzaSyAVKBWAa6O1sltmiFCWeqtFgSKzVmLlM1k" },
  },
  {
    name = 'default'
  }
})
