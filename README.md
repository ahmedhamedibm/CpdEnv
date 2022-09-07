# Cp4d-Cpdcli-Install


## Description
This project automatically runs the various cpd-cli commands required to install the Cloud Pak for Data control plane.

## Installation

You can utilize this project two ways. 
```bash
# Clone this rep
git clone https://github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install.git

# Change into the directory of the repo 
cd Cp4d-Cpdcli-Install

# Make both bash files executable
chmod +x cpd_vars.sh
chmod +x cpd_install.sh

```


### ----------------------------------------------------------------------------OR----------------------------------------------------------------------
#####	*Note ensure the url is up-to-date in the curl command below by going to the raw view of the cpd_install_helper.sh file in the repo and copying the link.
```bash
# Curl the helper script to create the directory ~/cpd_install_env that will contain cpd_vars.sh and cpd_install.sh 
curl -sSL https://raw.github.ibm.com/National-Northeast-1/Cp4d-Cpdcli-Install/master/cpd_install_helper.sh?token=AACTOHO2Z3M2MDLB2NXOYDLDEICQ4 | bash

# Change directory into ~/cpd_install_env
cd ~/cpd_install_env
```
## Usage
After installation or pulling the repo.
1. Edit the cpd_vars.sh and input the values appropriate to your cluster. There are comments in the cpd_vars.sh file to guide some of the information needed.
2. Run the command below based of your machine.
```bash
# On your machine run ./cpd_install.sh
./cpd_install.sh
# If you are using a bastion run
nohup ./cpd_install_bastion.sh
```


## Warning

This is for internal use only to simplify the process of installing Cloud Pak for Data using the cpd-cli. It has only been minimally tested on rhel and ubuntu images.
