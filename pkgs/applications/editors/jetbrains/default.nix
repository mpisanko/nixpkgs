{ lib, stdenv, callPackage, fetchurl
, python
, jdk, cmake, libxml2, zlib, python3, ncurses
}:

with stdenv.lib;

let
  mkJetBrainsProduct = callPackage ./common.nix { };

  # Sorted alphabetically

  buildIdea = { name, version, src, license, description, wmClass, ... }:
    (mkJetBrainsProduct rec {
      inherit name version src wmClass jdk;
      product = "IDEA";
      meta = with stdenv.lib; {
        homepage = https://www.jetbrains.com/idea/;
        inherit description license;
        longDescription = ''
          IDE for Java SE, Groovy & Scala development Powerful
          environment for building Google Android apps Integration
          with JUnit, TestNG, popular SCMs, Ant & Maven. Also known
          as IntelliJ.
        '';
        maintainers = with maintainers; [ edwtjo ];
        platforms = platforms.linux;
      };
    });

in

{
  # Sorted alphabetically

  idea-community = buildIdea rec {
    name = "idea-community-${version}";
    version = "2018.3.6"; /* updated by script */
    description = "Integrated Development Environment (IDE) by Jetbrains, community edition";
    license = stdenv.lib.licenses.asl20;
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
      sha256 = "1k5l54n9b7ddn3mlhhr1kq4sa3hprq0ds45mpyahqmsm482j8zs6"; /* updated by script */
    };
    wmClass = "jetbrains-idea-ce";
    update-channel = "IntelliJ IDEA RELEASE";
  };


}
