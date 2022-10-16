# Create working directory
mkdir -p ~/cpd_install_env || sudo mkdir -p ~/cpd_install_env

# Curl and create cpd_vars.sh as executable
curl -sSL https://raw.githubusercontent.com/ahmedhamedibm/CpdEnv/master/cpd_vars.sh > ~/cpd_install_env/cpd_vars.sh
chmod +x ~/cpd_install_env/cpd_vars.sh || sudo chmod +x ~/cpd_install_env/cpd_vars.sh

#Curl and create requirements.sh
curl -sSL https://raw.githubusercontent.com/ahmedhamedibm/CpdEnv/master/requirements.sh > ~/cpd_install_env/requirements.sh 
chmod +x ~/cpd_install_env/requirements.sh || sudo chmod +x ~/cpd_install_env/requirements.sh

# Curl and create cpd_install.sh as executable
curl -sSL https://raw.githubusercontent.com/ahmedhamedibm/CpdEnv/master/cpd_install.sh > ~/cpd_install_env/cpd_install.sh 
chmod +x ~/cpd_install_env/cpd_install.sh || sudo chmod +x ~/cpd_install.sh

