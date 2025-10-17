local csv = require("BCom.leerCSV")

local M = {}


--! FUNCIÓN QUE DEVUELVE UN COMANDO ALEATORIO A MOSTRAR EN LA VENTANA INCIAL--------------------------------
function M.comandoAleatorio()
    local keys = {}
    for k, _ in pairs(_COMANDOS) do
        table.insert(keys, k)
    end



    local comando = keys[math.random(1, #keys)]
    local info = _COMANDOS[comando]

    return comando, info.descripcion, info.dificultad
end 


--! FUNCIÓN QUE CONTROLA EL BUSCADOR DE COMANDOS---------------------------------------------------------
function M.busqueda(comando)
  print("Este comando sirve para " .. _COMANDOS[comando].descripcion)
end



return M
