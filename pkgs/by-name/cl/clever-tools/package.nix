{ lib
, buildNpmPackage
, fetchFromGitHub
, nodejs-18_x
}:

buildNpmPackage rec {
  pname = "clever-tools";

  version = "1fb6cc44b7086b8b9a4805efb5ef72bba609f012";

  nodejs = nodejs-18_x;

  src = fetchFromGitHub {
    owner = "CleverCloud";
    repo = "clever-tools";
    rev = "${version}";
    hash = "sha256-MVXot7PbS7Jwn2hwxLJf2PpgPap/hDta2OT4xwiBDu0=";
  };

  npmDepsHash = "sha256-CgT4QECuxcplA6xzzciSZzw+sq8gZR/CNH08GcBZsws=";

  dontNpmBuild = true;

  postInstall = ''
    mkdir -p $out/share/{bash-completion/completions,zsh/site-functions}
    $out/bin/clever --bash-autocomplete-script $out/bin/clever > $out/share/bash-completion/completions/clever
    $out/bin/clever --zsh-autocomplete-script $out/bin/clever > $out/share/zsh/site-functions/_clever
  '';

  meta = with lib; {
    homepage = "https://github.com/CleverCloud/clever-tools";
    description = "Deploy on Clever Cloud and control you applications, add-ons, services from command line";
    license = licenses.asl20;
    maintainers = with maintainers; [ floriansanderscc ];
  };
}
