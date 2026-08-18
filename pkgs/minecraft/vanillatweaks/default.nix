{ runCommandLocal }:

runCommandLocal "vanillatweaks.zip" { } ''
  cp ${./VanillaTweaks_r527227_MC1.21.x.zip} $out
''
