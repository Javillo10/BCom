local M = {}

M.config = {
    showInitPanel = true
}

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

    local funciones = require("BCom.funciones")
    local ventanaAprender = require("BCom.ventanaAprender")
    local leerCSV = require("BCom.leerCSV")
    local abrirVentanaInicio = require("BCom.abrirVentanaInicio")

    --funciones.config = M.config
    --ventanaAprender.config = M.config
    --leerCSV.config = M.config
    --abrirVentanaInicio.config = M.config

        
return M
