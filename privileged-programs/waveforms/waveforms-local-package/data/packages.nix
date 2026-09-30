# with builtins;

# fromJSON (readFile ./packages.json)
#

{
  waveforms = {
    version = "3.24.4";
    systems = {
      x86_64-linux = {
        path = ../src/digilent.waveforms_3.24.4_amd64.deb;
      };
    };
  };

  adept2-runtime = {
    version = "2.27.9";
    systems = {
      x86_64-linux = {
        path = ../src/digilent.adept.runtime_2.27.9-amd64.deb;
      };
    };
  };
}
