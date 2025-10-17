_CSV = require("BCom.csv")

local M = {}

function M.leerCSV()
    _COMANDOS = {}

    local info = debug.getinfo(1,'S')
    local script_path = info.source:sub(2):match("(.*/)") -- ruta de este archivo
    local rutaabsoluta = script_path .. "comandos.csv"

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
