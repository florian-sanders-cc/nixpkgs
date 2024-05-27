{ lib
, buildNpmPackage
, fetchFromGitHub
, nodejs_18
}:

buildNpmPackage rec {
  pname = "clever-tools";

  version = "3.7.0";

  nodejs = nodejs_18;

  src = fetchFromGitHub {
    owner = "CleverCloud";
    repo = "clever-tools";
    rev = version;
    hash = "sha256-Ce7lk+zTbyj3HmtIFui9ZA1FThZEytovrPCrmjMyX38=";
  };

  npmDepsHash = "sha256-VQXljlIHAE2o10cXQlsyhTvBSp3/ycQOJydQGNMiWuk=";

  dontNpmBuild = true;

  postInstall = ''
    mkdir -p $out/share/{bash-completion/completions,zsh/site-functions}
    $out/bin/clever --bash-autocomplete-script $out/bin/clever > $out/share/bash-completion/completions/clever
    $out/bin/clever --zsh-autocomplete-script $out/bin/clever > $out/share/zsh/site-functions/_clever
    rm $out/bin/install-clever-completion
    rm $out/bin/uninstall-clever-completion
  '';

  meta = with lib; {
    homepage = "https://github.com/CleverCloud/clever-tools";
    changelog = "https://github.com/CleverCloud/clever-tools/blob/${version}/CHANGELOG.md";
    description = "Deploy on Clever Cloud and control you applications, add-ons, services from command line";
    license = licenses.asl20;
    mainProgram = "clever";
    maintainers = with maintainers; [ floriansanderscc ];
  };
}
