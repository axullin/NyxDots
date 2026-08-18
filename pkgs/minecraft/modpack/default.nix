{ fetchPackwizModpack }:

# packwiz-managed Fabric pack (sources in ./pack). To change mods:
# cd pack && packwiz modrinth add <slug> && packwiz refresh
fetchPackwizModpack {
  src = ./pack;
  side = "both";
  packHash = "sha256-32pJe3IcxJd7laglVwGchN7k7I9QOoKQE4yStE1ezDM=";
}
