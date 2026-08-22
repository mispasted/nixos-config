{
    stdenv
,   fetchFromGitHub
}:

stdenv.mkDerivation {
    pname = "sddm-theme-superhotlogin";
    version = "unstable";

    src = fetchFromGitHub {
        owner = "0larszl0";
        repo = "SuperHotLogin";
        rev = "b15202c1acc9b8de73f81c903ca892c07291501c"; # Commit (No tags/releases)
        sha256 = "0n6r25ydmg2k9pqlb9mzl39z76dbggl1d7vs77y7cfvm7lsg80r7";
    };

    # Nothing needs to be compiled, etc.
    dontBuild = true;

    installPhase = ''
        runHook preInstall
        
        THEME_DIR="$out/share/sddm/themes/SuperHotTheme"
        mkdir -p "$THEME_DIR"
        cp -a ./* "$THEME_DIR"/ 

        runHook postInstall 
    '';
}
