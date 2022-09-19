# Create working directory
mkdir -p ~/cpd_install_env || sudo mkdir -p ~/cpd_install_env

# Curl and create cpd_vars.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_vars.sh?token=AACTOHNYH6WPCPBQSNNQPK3DGHKFE > ~/cpd_install_env/cpd_vars.sh
chmod +x ~/cpd_install_env/cpd_vars.sh || sudo chmod +x ~/cpd_install_env/cpd_vars.sh

#Curl and create requirements.sh
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/requirements.sh?token=AACTOHNPXPXL4SAOZOJ5CZLDGHKG2 > ~/cpd_install_env/requirements.sh 
chmod +x ~/cpd_install_env/requirements.sh || sudo chmod +x ~/cpd_install_env/requirements.sh

# Curl and create cpd_install.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install.sh?token=AACTOHK3IRAEZYGZV24Y77DDGHKAI > ~/cpd_install_env/cpd_install.sh 
chmod +x ~/cpd_install_env/cpd_install.sh || sudo chmod +x ~/cpd_install.sh

# Curl and create cpd_install_bastion.sh as executable
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install_bastion.sh?token=AACTOHJNZQNPMDG2SKI45HDDGHKC4 > ~/cpd_install_env/cpd_install_bastion.sh 
chmod +x ~/cpd_install_env/cpd_install_bastion.sh || sudo chmod +x ~/cpd_install_env/cpd_install_bastion.sh