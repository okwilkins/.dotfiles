{
  pkgs,
  config,
  osConfig,
  ...
}:
let
  src = pkgs.fetchFromGitHub {
    owner = "cursor";
    repo = "plugins";
    rev = "7a583913eb1b8d1a0ee76753d1a2cf072e7b54f9";
    hash = "sha256-prQwn1as83NuoYIDee+ZJ2ETDVNoFbHNabSwzpy70mk=";
  };
  dir = "${osConfig.system.xdg.configDir}/opencode";
  opencodeDir = "${config.home.homeDirectory}/${dir}";
in
{
  home.file = {
    "${dir}/pstack".source = "${src}/pstack";

    "${dir}/pstack-opencode.md".text = ''
      # Running pstack skills in OpenCode

      Use these instructions only when running pstack. Read skills, playbooks, `worker.md` and documentation from `${opencodeDir}/pstack/`.
      Leave those files unchanged.
      Load skills by ID with `skill`.
      In prompts, use `@poteto-mode` instead of `/poteto-mode`.

      - Use `subagent` for Cursor's `Task`. For `generalPurpose`, choose `explore` for read-only research and `general` otherwise.
        Keep the names `poteto-agent` and `comment-sicko`.
        Give `comment-sicko` the diff or file paths to review.
        Subagents run in the background.
        Resume a subagent with its `sessionID`.
      - Track playbook steps with `todowrite`. Use `question` when the user needs to choose.
      - When running `setup-pstack`, list the available OpenCode models and variants.
        Ask the user which model to use for each role.
        Save their choices as plain Markdown in `${opencodeDir}/pstack-models.md`.
        Do not write Cursor rules.
      - Before starting a subagent, check that file for the role's `provider/model#variant`.
        If the user chose no model for that role, omit `model` so the subagent inherits the session model.
        If all reviewers use the same model, say so.
      - Save new skills in the project's `.opencode/skills` directory.
      - Name any step you skip because OpenCode lacks a Cursor integration, such as Bugbot, Automations, cloud workers or transcript access.
        If you cannot run a required check, report what remains unverified.
    '';

    "${dir}/agents/poteto-agent.md".text = ''
      ---
      description: pstack delegate for a scoped engineering task
      mode: subagent
      ---
      Read ${src}/pstack/skills/poteto-mode/SKILL.md and its worker.md before
      starting. Apply the principles to the parent's brief; the parent owns
      playbook selection, todos and delegation.
    '';

    "${dir}/agents/comment-sicko.md".text = ''
      ---
      description: Read-only pstack reviewer for comments and workaround code
      mode: subagent
      permissions:
        - { action: "*", resource: "*", effect: deny }
        - { action: read, resource: "*", effect: allow }
        - { action: glob, resource: "*", effect: allow }
        - { action: grep, resource: "*", effect: allow }
        - { action: external_directory, resource: "${src}/pstack/**", effect: allow }
      ---
      Follow the reviewer instructions in ${src}/pstack/agents/comment-sicko.md.
      Review the files or diff supplied by the parent and report findings only.
    '';
  };
}
