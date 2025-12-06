{
  pkgs,
  ...
}:
let
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "delta";
    rev = "0674ec5114c08393d808e2516d153c7e6df00d41";
    sha256 = "0cnp2ry78mz8l4cf4618gx9v23n26gn7k1w4k5h5nqmm0yy17y96";
  };
in
{
  programs.git = {
    includes = [
      { path = "${src}/catppuccin.gitconfig"; }
    ];
    settings = {
      delta = {
        features = "catppuccin-mocha";
        "side-by-side" = true;
      };
    };
  };
}
