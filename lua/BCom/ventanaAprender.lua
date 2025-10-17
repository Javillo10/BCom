local funciones = require("BCom.funciones")

local M = {}

-- 🧠 Ventana principal de aprendizaje
function M.ventanaAprender()
  local buf = vim.api.nvim_create_buf(false, true)
  local espacioNombre = vim.api.nvim_create_namespace("bcom")
  local comandos = {}

  local width = 100
  local height = 10
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines
  local row = math.floor((editor_height - height) / 2)
  local col = math.floor((editor_width - width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "single",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_set_current_win(win)

  local title = "💥 [BCom] - APRENDIZAJE 💥"
  local padding = math.floor((width - #title) / 2)
  local centered_title = string.rep(" ", padding) .. title

  local lineas = {
    centered_title,
    string.rep("─", width),
    "",
  }

  -- 🔹 Elegimos 5 comandos aleatorios
  for i = 1, 5 do
    local comando, descripcion, difi = funciones.comandoAleatorio()
    table.insert(comandos, {
      comando = comando,
      descripcion = descripcion,
      dificultad = difi
    })
    table.insert(lineas, "El comando " .. comando .. " sirve para " .. descripcion)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lineas)

  -- 🔸 Estilo para el título
  vim.api.nvim_set_hl(0, "bcom", { fg = "#ffcc00", bold = true })
  vim.api.nvim_buf_set_extmark(buf, espacioNombre, 0, 0, {
    end_col = #centered_title,
    hl_group = "bcom",
  })

  -- 🔸 Mapear tecla para mostrar preguntas
  vim.keymap.set("n", "P", function()
    M.mostrarPreguntas(buf, comandos)
  end, { buffer = buf, noremap = true, silent = true })

  vim.bo[buf].modifiable = true
end





function M.mostrarPreguntas(buf, comandos)
  -- Limpiar buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  --[[ Convertimos comandos (diccionario) a lista
  local listaComandos = {}
  for cmd, info in pairs(comandos) do
    table.insert(listaComandos, {comando = cmd, descripcion = info.descripcion})
  end]]

  local total = #comandos
  local i = 1
  local aciertos = 0

  -- Función recursiva para preguntas
  for c, d in pairs(comandos) do
    if i > total then
      -- Mostrar resumen final
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", string.format("🎉 Test completado: %d/%d correctas", aciertos, total) })
      break
    end

    local pregunta = string.format("(%d/%d) ¿Qué comando sirve para %s?", i, total, d.descripcion)

    vim.ui.input({ prompt = pregunta }, function(respuesta)
      local resultado
      if respuesta then
        if respuesta == d.comando then
          resultado = "✅ Correcto. El comando es: " .. d.comando
          aciertos = aciertos + 1
        else
          resultado = "❌ Incorrecto. El comando sería: " .. d.comando
        end
      else
        resultado = "❌ Sin respuesta. El comando sería: " .. d.comando
      end

      -- Agregamos la pregunta y el resultado al buffer
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { pregunta, resultado, "" })

      i = i + 1
     -- siguiente pregunta
    end)
  end

end


-- 🧩 Ventana de test de preguntas
--[[function M.mostrarPreguntas(buf, comandos)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {}) -- limpia contenido

    local lineas = { "💥 [BCom] 💥 - Test de comandos", "" }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lineas)

    local total = #comandos
    local i = 1

    -- función interna recursiva
    local function hacerPregunta()
        if i > total then
            print("🎉 ¡Has completado el test!")
            return
        end

        local c = comandos[i]
        local pregunta = "¿Qué hace el comando " .. c.comando .. "? "

        vim.ui.input({ prompt = pregunta }, function(respuesta)
            if respuesta then
                if respuesta:lower() == c.descripcion:lower() then
                    print("✅ ¡Correcto!")
                else
                    print("❌ No, hace: " .. c.descripcion)
                end
            end

            i = i + 1
            hacerPregunta() -- lanza la siguiente pregunta
        end)
    end

    hacerPregunta()

end]]

return M

