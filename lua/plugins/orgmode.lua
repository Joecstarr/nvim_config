return {
    "hsteinshiromoto/todo.nvim",
    config = function()
        require("todo-nvim").setup({
            keymaps = {
                add_todo = "<leader>ta", -- Add new todo
                toggle_todo = "<leader>tc", -- Toggle completion (done)
                set_priority = "<leader>tp", -- Set priority
                open_todo_list = "<leader>tl", -- Open todo list
            },
        })
    end,
}
