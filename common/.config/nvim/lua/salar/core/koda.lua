local M = {}

local variant_overrides = {
	dark = {
		bg = "#050505",
		fg = "#d4d4d4",
		line = "#1a1a1a",
		comment = "#50585d",
		const = "#d9ba73",
		func = "#ffffff",
		string = "#ffffff",
		emphasis = "#ffffff",
		info = "#8ebeec",
		success = "#86cd82",
		warning = "#d9ba73",
		danger = "#ff7676",
	},
	moss = {
		bg = "#090d0e",
		line = "#151d1e",
	},
}

local function apply_python_matches(bufnr)
	vim.api.nvim_buf_call(bufnr, function()
		pcall(vim.cmd, "syntax clear SalarPythonConstant")
		pcall(vim.cmd, [[syntax match SalarPythonConstant /\<[A-Z][A-Z0-9_]\+\>/]])
	end)
end

local function setup_language_highlights()
	local group = vim.api.nvim_create_augroup("SalarKodaLanguageHighlights", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "python",
		callback = function(args)
			apply_python_matches(args.buf)
		end,
	})

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype == "python" then
			apply_python_matches(bufnr)
		end
	end
end

local function on_highlights(hl, c)
	hl.SalarPythonConstant = { fg = c.const }
	hl.Search = { fg = c.bg, bg = c.const }
	hl.CurSearch = { fg = c.bg, bg = c.const, bold = true }
	hl.IncSearch = { fg = c.bg, bg = c.const }
	hl.PmenuMatch = { fg = c.const, bold = true }
	hl.Question = { fg = c.const }
	hl.WarningMsg = { fg = c.const }

	hl["@constant"] = { fg = c.const }
	hl["@constant.builtin"] = { fg = c.const }
	hl["@constant.macro"] = { fg = c.const }
	hl["@number"] = { fg = c.const }
	hl["@number.float"] = { fg = c.const }
	hl["@boolean"] = { fg = c.const }
	hl["@markup.raw"] = { fg = c.const }
	hl["@markup.raw.block"] = { fg = c.const }
end

local function variant_for(name)
	if name == "koda-dark" then
		return "dark"
	end

	if name == "koda-moss" then
		return "moss"
	end

	if name == "koda" then
		return vim.o.background == "light" and "light" or "dark"
	end

	if name == "koda-light" then
		return "light"
	end

	if name == "koda-glade" then
		return "glade"
	end

	return nil
end

function M.setup(name)
	local variant = variant_for(name)
	if not variant then
		return
	end

	require("koda").setup({
		colors = variant_overrides[variant] or {},
		on_highlights = on_highlights,
	})

	if variant == "dark" then
		setup_language_highlights()
	end
end

return M
