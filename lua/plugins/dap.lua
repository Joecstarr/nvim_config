return {
    {
        "mfussenegger/nvim-dap",
        recommended = true,
        desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

        dependencies = {
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
            {
                "julianolf/nvim-dap-lldb",
            },
            "Civitasv/cmake-tools.nvim",
        },

        keys = {
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Breakpoint Condition",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Run/Continue",
            },
            {
                "<leader>dC",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dg",
                function()
                    require("dap").goto_()
                end,
                desc = "Go to Line (No Execute)",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>dj",
                function()
                    require("dap").down()
                end,
                desc = "Down",
            },
            {
                "<leader>dk",
                function()
                    require("dap").up()
                end,
                desc = "Up",
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "Run Last",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>dP",
                function()
                    require("dap").pause()
                end,
                desc = "Pause",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "Toggle REPL",
            },
            {
                "<leader>ds",
                function()
                    require("dap").session()
                end,
                desc = "Session",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
            {
                "<leader>dw",
                function()
                    require("dap.ui.widgets").hover()
                end,
                desc = "Widgets",
            },
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("uv")
        end,
    },
    {
        "julianolf/nvim-dap-lldb",
        dependencies = { "mfussenegger/nvim-dap" },
        opts = {
            codelldb_path = os.getenv("CODELLDB_BIN_PATH"),
        },
    },
    {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            winbar = {
                sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
                controls = { enabled = true },
            },
        },
        keys = {
            { "<leader>du", "<cmd>DapViewToggle<cr>", desc = "Open dapview" },
        },
    },
    -- {
    --     "miroshQa/debugmaster.nvim",
    --     -- osv is needed if you want to debug neovim lua code. Also can be used
    --     -- as a way to quickly test-drive the plugin without configuring debug adapters
    --     dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind" },
    --     config = function()
    --         local dm = require("debugmaster")
    --         -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
    --         -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
    --         vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
    --         -- If you want to disable debug mode in addition to leader+d using the Escape key:
    --         vim.keymap.set("n", "<Esc>", dm.mode.disable)
    --
    --         dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
    --     end,
    -- },
}
