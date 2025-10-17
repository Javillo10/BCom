local funciones = require("BCom.funciones")

local M = {}

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

  vim.api.nvim_set_hl(0, "bcom", { fg = "#ffcc00", bold = true })
  vim.api.nvim_buf_set_extmark(buf, espacioNombre, 0, 0, {
    end_col = #centered_title,
    hl_group = "bcom",
  })

  vim.keymap.set("n", "P", function()
    M.mostrarPreguntas(buf, comandos)
  end, { buffer = buf, noremap = true, silent = true })

  vim.bo[buf].modifiable = true
end





function M.mostrarPreguntas(buf, comandos)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  --[[ Convertimos comandos (diccionario) a lista
  local listaComandos = {}
  for cmd, info in pairs(comandos) do
    table.insert(listaComandos, {comando = cmd, descripcion = info.descripcion})
  end]]

  local total = #comandos
  local i = 1
  local aciertos = 0

  for c, d in pairs(comandos) do
    if i > total then
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

      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { pregunta, resultado, "" })

      i = i + 1
     -- siguiente pregunta
    end)
  end

end

return M

