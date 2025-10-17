-- lua/plugins/BCom_spec.lua
return {
    "mi_usuario/BCom",  -- nombre ficticio, para referencia
    config = function()
        require("plugins.BCom")  -- esto carga tu módulo normal
    end,
}

