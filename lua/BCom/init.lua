local M = {}

    local funciones = require("BCom.funciones")
    local ventanaAprender = require("BCom.ventanaAprender")
    local leerCSV = require("BCom.leerCSV")
    local abrirVentanaInicio = require("BCom.abrirVentanaInicio")

M.setup = function(opts)
    opts = opts or {}

    local showInitPanel = opts.showInitPanel
    if showInitPanel == nil then
        showInitPanel = true
    end
    

    leerCSV.leerCSV();

    if showInitPanel then
        abrirVentanaInicio.abrirVentanaInicio()
    end

    --funciones.config = M.config
    --ventanaAprender.config = M.config
    --leerCSV.config = M.config
    --abrirVentanaInicio.config = M.config
end

        
