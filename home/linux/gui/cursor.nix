{
  pkgs,
  projectVars,
  ...
}:
let
  rosePineCursorHyprcursor = pkgs.fetchFromGitHub {
    owner = "ndom91";
    repo = "rose-pine-hyprcursor";
    rev = "v0.3.2";
    sha256 = "sha256-ArUX5qlqAXUqcRqHz4QxXy3KgkfasTPA/Qwf6D2kV0U=";
  };
in
{
  home.file."${projectVars.xdg.dataDir}/icons/rose-pine-hyprcursor".source = "${
    rosePineCursorHyprcursor
  }";
}
