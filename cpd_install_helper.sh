mkdir -p ~/cpd_install_env || sudo mkdir -p ~/cpd_install_env
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHKDRGKDJKEKFVPZSIDDED3MA > ~/cpd_install_env/cpd_vars.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHKDRGKDJKEKFVPZSIDDED3MA > ~/cpd_install_env/cpd_vars.sh
chmod +x ~/cpd_install_env/cpd_vars.sh || sudo chmod +x ~/cpd_install_env/cpd_vars.sh
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHO6WPTTIFLBGRNFD6TDED7SA > ~/cpd_install_env/cpd_install.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHO6WPTTIFLBGRNFD6TDED7SA > ~/cpd_install_env/cpd_install.sh
chmod +x ~/cpd_install_env/cpd_install.sh || sudo chmod +x ~/cpd_install.sh