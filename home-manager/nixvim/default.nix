{ inputs, outputs, lib, config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [ plenary-nvim ];
    package = pkgs.neovim-nightly;
    colorschemes.base16 = {
      enable = true;
      useTruecolor = true;
      colorscheme = lib.toLower config.colorScheme.name;
    };
    options = {
      # Context
      number = true;
      relativenumber = true;
      colorcolumn = "120";
      scrolloff = 4;
      signcolumn = "yes";

      # Filetypes
      encoding = "utf8";
      fileencoding = "utf8";

      # Search
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;

      # Whitespace
      expandtab = true;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 4;

      # Splits
      splitright = true;
      splitbelow = true;

      # Code completion
      completeopt = [ "menuone" "noselect" "noinsert" ];
      # shortmess = shortmess + { c = true ;} ?
      # api.nvim_set_option('updatetime', 300) ?

    };
    plugins = {
      bufferline = { enable = true; };
      nvim-tree = { enable = true; };
      lualine = { enable = true; };
      nvim-autopairs = { enable = true; };
      nvim-cmp = { enable = true; };
      telescope = { enable = true; };
    };
    globals.mapleader = ",";
    globals.localleader = "\\";
    keymaps = [
      {
        mode = "n";
        key = "<C-A-Left>";
        action = "<cmd>bp<CR>";
      }
      {
        mode = "n";
        key = "<C-A-Right>";
        action = "<cmd>bn<CR>";
      }
      {
        mode = "n";
        key = "<C-q>";
        action = "<cmd>bd<CR>";
      }
      {
        mode = "n";
        key = "ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "n";
        action = "<cmd>NvimTreeToggle<CR>";
      }
    ];
  };
}
