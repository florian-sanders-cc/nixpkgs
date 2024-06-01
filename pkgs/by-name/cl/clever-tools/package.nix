{ lib
, buildNpmPackage
, fetchFromGitHub
, nodejs-18_x
}:

buildNpmPackage rec {
  pname = "clever-tools";

  version = "3.5.1";

  nodejs = nodejs-18_x;

  src = fetchFromGitHub {
    owner = "CleverCloud";
    repo = "clever-tools";
    rev = "${version}";
    hash = "sha256-k3k8PoJVnTDExz2MbuEPTnIygNj8JxPw7t6SOQWNsGY=";
  };

  npmDepsHash = "sha256-quNBAWC1wAsIVcky7H8mYlw2sJkndVSbnlyRaJGndT0=";

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
