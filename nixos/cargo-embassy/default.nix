{ pkgs }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-embassy";
  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "adinack";
    repo = "cargo-embassy";
    rev = version;
    hash = "sha256-VwqAULN11MneA3fJA3GJExJwRYGiC22QiYvzplrHgqg=";
  };

  cargoSha256 = "sha256-PDETSOQpCKkdb17urxkrxGah6pgjW/8u72uNm7iVEGE=";
  cargoPatches = [ ./Cargo.lock.patch ];

  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = [ pkgs.udev ];
}
