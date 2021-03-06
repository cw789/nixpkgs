{ lib, stdenv, fetchFromGitHub, gnugrep, nix, nixFlakes }:

stdenv.mkDerivation rec {
  pname = "nix-direnv";
  version = "1.2.4";

  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "nix-direnv";
    rev = version;
    sha256 = "sha256-87x+MRQ1SjtN+wNCy42VJwlRwgQzHjNEK3J1bkvo7eQ=";
  };

  # Substitute instead of wrapping because the resulting file is
  # getting sourced, not executed:
  postPatch = ''
    sed -i "1a NIX_BIN_PREFIX=${nixFlakes}/bin/" direnvrc
    substituteInPlace direnvrc --replace "grep" "${gnugrep}/bin/grep"
  '';

  installPhase = ''
    runHook preInstall
    install -m500 -D direnvrc $out/share/nix-direnv/direnvrc
    runHook postInstall
  '';

  meta = with lib; {
    description = "A fast, persistent use_nix implementation for direnv";
    homepage    = "https://github.com/nix-community/nix-direnv";
    license     = licenses.mit;
    platforms   = platforms.unix;
    maintainers = with maintainers; [ mic92 ];
  };
}
