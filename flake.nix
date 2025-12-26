{
  description = "Hackerman";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # --- CONNECTIVITY ---
          netcat-gnu      # Connects to challenge servers.
          nmap            # Simple network scanning.
          wget            # Downloading challenge files.

          # --- FORENSICS ---
          file            # Tells you if a file is a JPEG, ELF, Text, etc.
          binutils        # Includes 'strings' (Finds text in binary files).
          exiftool        # Reads metadata (GPS, Author) from images.
          binwalk         # Checks if one file is hidden inside another.
          unzip           # Extracting archives.

          # --- NETWORK ---
          dig             # DNS lookup
          wireshark       # Network protocol analyser

          # --- SCRIPTING & CRYPTO ---
          python3
          gcc
        ];
      };
    };
}
