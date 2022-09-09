# Create working directory
mkdir -p ~/cpd_install_env || sudo mkdir -p ~/cpd_install_env

# Curl and create cpd_vars.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHLGBSC6PKTTEI3XED3DES5CM > ~/cpd_install_env/cpd_vars.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHLGBSC6PKTTEI3XED3DES5CM > ~/cpd_install_env/cpd_vars.sh
chmod +x ~/cpd_install_env/cpd_vars.sh || sudo chmod +x ~/cpd_install_env/cpd_vars.sh

#Curl and create requirements.sh
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/requirements.sh?token=AACTOHLMWZABTVSX4FGKS7LDES47M > ~/cpd_install_env/requirements.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/requirements.sh?token=AACTOHLMWZABTVSX4FGKS7LDES47M > ~/cpd_install_env/requirements.sh
chmod +x ~/cpd_install_env/requirements.sh || sudo chmod +x ~/cpd_install_env/requirements.sh

# Curl and create cpd_install.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHNJBQKNH75HOCTLCNLDES4YU > ~/cpd_install_env/cpd_install.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHNJBQKNH75HOCTLCNLDES4YU > ~/cpd_install_env/cpd_install.sh
chmod +x ~/cpd_install_env/cpd_install.sh || sudo chmod +x ~/cpd_install.sh

# Curl and create cpd_install_bastion.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install_bastion.sh?token=AACTOHISYUM426MNYRJ56JTDES44I > ~/cpd_install_env/cpd_install_bastion.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install_bastion.sh?token=AACTOHISYUM426MNYRJ56JTDES44I > ~/cpd_install_env/cpd_install_bastion.sh
chmod +x ~/cpd_install_env/cpd_install_bastion.sh || sudo chmod +x ~/cpd_install_env/cpd_install_bastion.sh