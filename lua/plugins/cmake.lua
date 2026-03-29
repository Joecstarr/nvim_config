return {
    "Civitasv/cmake-tools.nvim",
    opts = {
        cmake_regenerate_on_save = true,
        cmake_dap_configuration = { -- debug settings for cmake
            name = "cpp",
            type = "lldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal",
            initCommands = {
                "type format add --format hex int",
                "type format add --format hex long",
                "type format add --format hex 'long long'",
                "type format add --format hex 'signed char'",
                "type format add --format hex 'unsigned char'",
                -- "settings set display-format x",
                -- "settings set target.disassembly-display auto",
            },
        },
        cmake_generate_options = {
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
            "-DCMAKE_COLOR_DIAGNOSTICS=TRUE",
            "-DCPPCHECK_OFF=TRUE",
            "-G Ninja",
        }, -- this will be passed when invoke `CMakeGenerate`
        cmake_build_directory = function()
            local osys = require("cmake-tools.osys")
            if osys.iswin32 then
                return ".build\\${variant:buildType}"
            end
            return ".build/${variant:buildType}"
        end,
    },
}
-- "setupCommands": [
--     {
--         "description": "Enable pretty-printing for gdb",
--         "text": "-enable-pretty-printing",
--         "ignoreFailures": true
--     },
--     { "text": "set output-radix 16" }
-- ]
