# Create working directory
mkdir -p ~/cpd_install_env || sudo mkdir -p ~/cpd_install_env

# Curl and create cpd_vars.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/cpd_vars.sh?token=AACTOHPBPBJFEWG7TFAJCOTDEO2JK > ~/cpd_install_env/cpd_vars.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/cpd_vars.sh?token=AACTOHPBPBJFEWG7TFAJCOTDEO2JK > ~/cpd_install_env/cpd_vars.sh
chmod +x ~/cpd_install_env/cpd_vars.sh || sudo chmod +x ~/cpd_install_env/cpd_vars.sh

#Curl and create requirements.sh
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/requirements.sh?token=AACTOHJ3WMKRXFQCBHOSPITDEOZ76 > ~/cpd_install_env/requirements.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/requirements.sh?token=AACTOHJ3WMKRXFQCBHOSPITDEOZ76 > ~/cpd_install_env/requirements.sh
chmod +x ~/cpd_install_env/requirements.sh || sudo chmod +x ~/cpd_install_env/requirements.sh

# Curl and create cpd_install.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/cpd_install.sh?token=AACTOHMAIFQJN3I2MQFHQVLDEO2MM > ~/cpd_install_env/cpd_install.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/cpd_install.sh?token=AACTOHMAIFQJN3I2MQFHQVLDEO2MM > ~/cpd_install_env/cpd_install.sh
chmod +x ~/cpd_install_env/cpd_install.sh || sudo chmod +x ~/cpd_install.sh

# Curl and create cpd_install_bastion.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/cpd_install_bastion.sh?token=AACTOHOBJDIQUTQDJ6D6FCTDEO2PI > ~/cpd_install_env/cpd_install_bastion.sh || sudo curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/dev/cpd_install_bastion.sh?token=AACTOHOBJDIQUTQDJ6D6FCTDEO2PI > ~/cpd_install_env/cpd_install_bastion.sh
chmod +x ~/cpd_install_env/cpd_install_bastion.sh || sudo chmod +x ~/cpd_install_env/cpd_install_bastion.sh