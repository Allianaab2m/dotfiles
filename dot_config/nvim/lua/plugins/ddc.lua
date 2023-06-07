return {
	"Shougo/ddc.vim",
	enabled = false,
	dependencies = {
		"vim-denops/denops.vim",

		-- Snippet
		"hrsh7th/vim-vsnip",
		"hrsh7th/vim-vsnip-integ",
		"rafamadriz/friendly-snippets",

		-- UI
		"Shougo/pum.vim",
		"Shougo/ddc-ui-pum",

		-- Source
		"Shougo/ddc-source-around",
		"Shougo/ddc-source-nvim-lsp",
		"Shougo/ddc-source-cmdline",
		"Shougo/ddc-source-cmdline-history",
		"LumaKernel/ddc-source-file",

		-- Filter
		"tani/ddc-fuzzy",

		-- Inline Preview
		{
			"matsui54/denops-popup-preview.vim",
			lazy = false,
		},
	},
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
		local items = require("utils").icons.kinds

		---@params opts table
		local function ddc_patch_global(opts)
			for key, value in pairs(opts) do
				vim.fn["ddc#custom#patch_global"](key, value)
			end
		end

		local function pum_set_option(opts)
			for key, value in pairs(opts) do
				vim.fn["pum#set_option"](key, value)
			end
		end

		ddc_patch_global({
			autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged" },
			ui = "pum",
			sources = { "nvim-lsp", "around", "skkeleton" },
			cmdlineSources = {
				[":"] = { "cmdline", "cmdline-history", "file", "around" },
			},
			sourceOptions = {
				_ = {
					matchers = { "matcher_fuzzy" },
					sorters = { "sorter_fuzzy" },
					converters = { "converter_fuzzy" },
					dup = "keep",
				},
				["nvim-lsp"] = {
					mark = "[LSP]",
					forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
				},
				around = {
					mark = "[A]",
				},
				cmdline = {
					mark = "[Cmd]",
				},
				["cmdline-history"] = {
					mark = "[CmdH]",
				},
				skkeleton = {
					mark = "[SKK]",
					matchers = { "skkeleton" },
					sorters = {},
				},
				file = {
					mark = "[F]",
					isVolatile = true,
					forceCompletionPattern = "\\S/\\S*",
				},
			},
			sourceParams = {
				["nvim-lsp"] = {
					kindLabels = items,
				},
				around = {
					maxSize = 500,
				},
			},
		})

		pum_set_option({
			item_orders = { "abbr", "kind", "menu" },
			padding = true,
			highlight_columns = {
				kind = "CmpItemKind",
				abbr = "CmpItemAbbr",
				menu = "CmpItemMenu",
			},
			highlight_normal_menu = "Normal",
			highlight_selected = "CursorLine",
			highlight_matches = "CmpItemAbbrMatch",
			use_setline = true,
		})

		vim.keymap.set("i", "<Tab>", function()
			if vim.fn["vsnip#jumpable"](1) == 1 then
				return "<Plug>(vsnip-jump-next)"
			elseif vim.fn["pum#visible"]() == true then
				return "<Cmd>call pum#map#insert_relative(+1)<CR>"
			else
				return "<Tab>"
			end
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<S-Tab>", function()
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				return "<Plug>(vsnip-jump-prev)"
			elseif vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#insert_releative(-1)<CR>"
			else
				return "<S-Tab>"
			end
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<CR>", function()
			if vim.fn["vsnip#expandable"]() == 1 then
				return "<Plug>(vsnip-expand)"
			elseif vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#confirm()<CR>"
			else
				return "<CR>"
			end
		end, { expr = true, silent = true })

		vim.cmd([[
      nnoremap :       <Cmd>call CommandlinePre()<CR>:

      function! CommandlinePre() abort
          cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
          cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
          cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
          cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

          autocmd User DDCCmdlineLeave ++once call CommandlinePost()

          " Enable command line completion for the buffer
          call ddc#enable_cmdline_completion()
      endfunction
      function! CommandlinePost() abort
          silent! cunmap <Tab>
          silent! cunmap <S-Tab>
          silent! cunmap <C-y>
          silent! cunmap <C-e>
      endfunction
    ]])

		vim.fn["popup_preview#enable"]()

		vim.fn["ddc#enable"]()
	end,
}
