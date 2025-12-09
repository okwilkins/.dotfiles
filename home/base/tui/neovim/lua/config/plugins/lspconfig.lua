return function()
    -- Lua
    vim.lsp.enable("lua_ls")

    -- Markdown
    vim.lsp.enable("marksman")

    -- YAML
    vim.lsp.config("yamlls", {
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                completion = true,
                hover = true,
                validate = true,
                format = {
                    enable = true,
                },
                schemas = {
                    kubernetes = "*.yaml",
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                    ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                    ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                },
            },
        },
    })
    vim.lsp.enable("yamlls")

    -- Terraform
    vim.lsp.config("terraformls", {
        filetypes = { "terraform", "terraform-vars", "tf" },
    })
    vim.lsp.enable("terraformls")

    -- Go
    vim.lsp.enable("gopls")

    -- Python
    vim.lsp.enable("ruff")
    vim.lsp.enable("pyright")

    -- Nix
    vim.lsp.enable("nixd")

    -- CSS
    vim.lsp.enable("cssls")

    -- Zig
    vim.lsp.config("zls", {
        settings = {
            zls = {
                enable_build_on_save = true,
                build_on_save_step = "check",
            },
        },
    })
    vim.lsp.enable("zls")

    -- C++
    vim.lsp.config("clangd", {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
        },
    })
    vim.lsp.enable("clangd")
end
