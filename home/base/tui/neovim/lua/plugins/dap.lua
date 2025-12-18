return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")

            dap.adapters.lldb = {
                type = "executable",
                command = "lldb-dap",
                name = "lldb",
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }

            dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

            local has_ui, ui = pcall(require, "dapui")
            if has_ui then
                ui.setup()
                dap.listeners.before.attach.dapui_config = function()
                    ui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                    ui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                    ui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                    ui.close()
                end
            end
        end,
    },
}
