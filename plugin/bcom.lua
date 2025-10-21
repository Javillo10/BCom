local bcom = require("BCom")
--local funciones = require("BCom.funciones")
--local csv = require("BCom.leerCSV")
--local ventanaInicio = require("BCom.abrirVentanaInicio")
--local ventanaAprender = require("BCom.ventanaAprender")

math.randomseed(os.time())

bcom.csv.leerCSV()

if bcom.config.showInitPanel then
    bcom.ventanaInicio.abrirVentanaInicio()
end

vim.api.nvim_create_user_command("Bcom", function(opts)
  bcom.funciones.busqueda(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("BcomA", function()
  bcom.ventanaAprender.ventanaAprender()
end, {})


