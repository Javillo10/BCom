local funciones = require("miPlugins.BCom.funciones")
local csv = require("miPlugins.BCom.leerCSV")
local ventanaInicio = require("miPlugins.BCom.abrirVentanaInicio")
local ventanAprender = require("miPlugins.BCom.ventanaAprender")

math.randomseed(os.time())

csv.leerCSV()
ventanaInicio.abrirVentanaInicio()

vim.api.nvim_create_user_command("Bcom", function(opts)
  funciones.busqueda(opts.args)
end, {nargs = 1})

vim.api.nvim_create_user_command("BcomA", function()
    ventanAprender.ventanaAprender()
end, {})

