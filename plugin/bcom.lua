local funciones = require("BCom.funciones")
local csv = require("BCom.leerCSV")
local ventanaInicio = require("BCom.abrirVentanaInicio")
local ventanaAprender = require("BCom.ventanaAprender")

math.randomseed(os.time())

csv.leerCSV()

ventanaInicio.abrirVentanaInicio()

vim.api.nvim_create_user_command("Bcom", function(opts)
  funciones.busqueda(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("BcomA", function()
  ventanaAprender.ventanaAprender()
end, {})


