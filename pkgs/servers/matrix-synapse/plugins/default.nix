{ callPackage }:

{
  matrix-synapse-ldap3 = callPackage ./ldap3.nix { };
  matrix-synapse-pam = callPackage ./pam.nix { };
  matrix-synapse-shared-secret-auth = callPackage ./shared-secret-auth.nix { };
}
