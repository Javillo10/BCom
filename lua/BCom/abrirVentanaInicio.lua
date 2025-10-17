local funciones = require("BCom.funciones")

local M = {}

--! FUNCIÓN PARA CONFIGURAR Y ABRIR LA VENTNANA FLOTANTE INICIAL----------------------------------------
function M.abrirVentanaInicio()
    local buf = vim.api.nvim_create_buf(false, true)
    local espacioNombre = vim.api.nvim_create_namespace("bcom")

    local width = 100
    local height = 6
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines
    local row = math.floor((editor_height - height) / 2)
    local col = math.floor((editor_width - width) / 2)

    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "single",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_set_current_win(win)

    local comando, descripcion, dificultad = funciones.comandoAleatorio()


    local title = "💥 BCom 💥"
    -- Calcula los espacios a la izquierda
    local padding = math.floor((width - #title) / 2)
    local centered_title = string.rep(" ", padding) .. title

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        centered_title,
        "------------------------------------------------------------------------------------------------------------------------------------------------------",
        "",
        "El comando " .. comando .. " sirve para " .. descripcion .. ", cuta dificultad es " .. dificultad,
    })

    vim.bo[buf].modifiable = true

    local comienzoComando = string.find("El comando " .. comando .. " sirve para " .. descripcion, comando, 1, true)
    local finComando = comienzoComando + #comando

    vim.api.nvim_set_hl(0, "bcom", {fg = "#ffcc00", bold = true})
    vim.api.nvim_set_hl(0, "estiloComando", {fg = "#00ff99", italic = true})

    vim.api.nvim_buf_set_extmark(buf, espacioNombre, 0, 0, {
        end_col = padding + #title,
        hl_group = "bcom",
    })
    vim.api.nvim_buf_set_extmark(buf, espacioNombre, 3, comienzoComando - 1, {
        end_col = finComando - 1,
        hl_group = 'estiloComando',
    })

    vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", "<cmd>close<cr>", { noremap = true, silent = true })
  
end


return M


