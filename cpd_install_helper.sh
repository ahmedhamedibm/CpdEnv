# Create working directory
mkdir -p ~/cpd_install_env || sudo mkdir -p ~/cpd_install_env

# Curl and create cpd_vars.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHIAAR4RK3XPHVBG2MDDEIBP6 > ~/cpd_install_env/cpd_vars.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHIAAR4RK3XPHVBG2MDDEIBP6 > ~/cpd_install_env/cpd_vars.sh
chmod +x ~/cpd_install_env/cpd_vars.sh || sudo chmod +x ~/cpd_install_env/cpd_vars.sh

# Curl and create cpd_install.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHL3LMKXK54PKKNQWJDDENQ3S > ~/cpd_install_env/cpd_install.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHL3LMKXK54PKKNQWJDDENQ3S > ~/cpd_install_env/cpd_install.sh
chmod +x ~/cpd_install_env/cpd_install.sh || sudo chmod +x ~/cpd_install.sh

# Curl and create cpd_install_bastion.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install_bastion.sh?token=AACTOHLSWLLJN2Y4RFE2WGDDENQXC > ~/cpd_install_env/cpd_install_bastion.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install_bastion.sh?token=AACTOHLSWLLJN2Y4RFE2WGDDENQXC > ~/cpd_install_env/cpd_install_bastion.sh
chmod +x ~/cpd_install_env/cpd_install_bastion.sh || sudo chmod +x ~/cpd_install_env/cpd_install_bastion.sh