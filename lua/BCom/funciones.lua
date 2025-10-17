local csv = require("BCom.leerCSV")

local M = {}


function M.comandoAleatorio()
  if not _COMANDOS then
    print("❌ [BCom] No hay comandos cargados. Llama primero a leerCSV().")
    return nil, nil, nil
  end

  -- Crear lista de claves
  local keys = {}
  for k in pairs(_COMANDOS) do
    table.insert(keys, k)
  end

  -- Elegir aleatorio
  local cmd = keys[math.random(#keys)]
  local info = _COMANDOS[cmd]

  if not info then
    print("⚠️ [BCom] No se encontró información para el comando: " .. tostring(cmd))
    return cmd, "Descripción no disponible", "?"
  end

  return cmd, info.descripcion, info.dificultad
end


function M.busqueda(comando)
  print("Este comando sirve para " .. _COMANDOS[comando].descripcion)
end



return M
