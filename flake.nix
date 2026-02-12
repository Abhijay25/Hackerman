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
          curl            # HTTP requests and API interaction.

          # --- FORENSICS ---
          file            # Tells you if a file is a JPEG, ELF, Text, etc.
          binutils        # Includes 'strings' (Finds text in binary files).
          exiftool        # Reads metadata (GPS, Author) from images.
          binwalk         # Checks if one file is hidden inside another.
          unzip           # Extracting archives.
          foremost        # File carving from disk images.
          p7zip           # 7z archive support.

          # --- STEGANOGRAPHY ---
          steghide        # Hide/extract data in images.
          stegseek        # Fast steghide cracker.

          # --- NETWORK ---
          dig             # DNS lookup.
          wireshark       # Network protocol analyser.
          tcpdump         # Command-line packet analyzer.

          # --- REVERSE ENGINEERING ---
          gdb             # GNU debugger for binaries.
          radare2         # Reverse engineering framework.
          ghidra          # NSA's reverse engineering tool.
          ltrace          # Library call tracer.
          strace          # System call tracer.
          patchelf        # Modify ELF executables.

          # --- BINARY EXPLOITATION ---
          checksec        # Check binary security properties.

          # --- SCRIPTING & CRYPTO ---
          python3
          python3Packages.pwntools    # CTF framework for exploits.
          python3Packages.pycryptodome # Crypto library.
          python3Packages.requests    # HTTP library.
          gcc
          openssl         # Crypto operations.

          # --- HASHING & CRACKING ---
          hashcat         # GPU password cracker.
          john            # John the Ripper password cracker.

          # --- WEB EXPLOITATION ---
          jq              # JSON parser for APIs.
          sqlmap          # SQL injection tool.

          # --- UTILITIES ---
          xxd             # Hex dump/reverse tool.
          hexedit         # Terminal hex editor.
          coreutils       # Standard Unix utilities (includes base64).
          zip             # Creating zip archives.
          nasm            # Assembler for x86.
        ];

        # Location of 'dumpcap' wrapper
        shellHook = ''
          export PATH="/run/wrappers/bin:$PATH"
        '';
      };
    };
}
