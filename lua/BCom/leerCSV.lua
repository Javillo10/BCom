_CSV = require("BCom.csv")

local M = {}

function M.leerCSV()
    _COMANDOS = {}

    local rutaabsoluta = vim.fn.stdpath("config") .. "/lua/miPlugins/BCom/comandos.csv"

    local f = io.open(rutaabsoluta, "r")

    if f ~= nil then
        local contenido = f:read("*a")
        f:close()

        local reader = _CSV.openstring(contenido)

        for campos in reader:lines() do
            _COMANDOS[campos[1]] = {descripcion = campos[2], dificultad = campos[3]}
        end
    else
        print("[error]::no existe archivo")
    end
end

return M
