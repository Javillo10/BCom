local csv = require("BCom.leerCSV")

local M = {}


function M.comandoAleatorio()
    local keys = {}
    for k, _ in pairs(_COMANDOS) do
        table.insert(keys, k)
    end



    local comando = keys[math.random(1, #keys)]
    local info = _COMANDOS[comando]

    return comando, info.descripcion, info.dificultad
end 


function M.busqueda(comando)
  print("Este comando sirve para " .. _COMANDOS[comando].descripcion)
end



return M
