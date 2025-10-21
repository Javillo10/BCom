local M = {}

M.config = {
    showInitPanel = true
}

function M.setup(opts)
    M.config = vim.tbl_deep_extend("forece", M.config, opts or {})

        local funciones = require("BCom.funciones")
        local ventanaAprender = require("BCom.ventanaAprender")
        local leerCSV = require("BCom.leerCSV")
        local abrirVentanaInicio = require("BCom.abrirVentanaInicio")

        --funciones.config = M.config
        --ventanaAprender.config = M.config
        --leerCSV.config = M.config
        abrirVentanaInicio.config = M.config

    end
        
return M
