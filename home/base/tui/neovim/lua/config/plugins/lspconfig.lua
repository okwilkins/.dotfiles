return function()
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({})

    -- Markdown
    lspconfig.marksman.setup({})

    -- YAML
    lspconfig.yamlls.setup({
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

    -- Terraform
    lspconfig.terraformls.setup({
        filetypes = { "terraform", "terraform-vars", "tf" },
    })

    -- Go
    lspconfig.gopls.setup({})

    -- Python
    lspconfig.ruff.setup({})
    lspconfig.pyright.setup({})

    -- Nix
    lspconfig.nixd.setup({})
end
