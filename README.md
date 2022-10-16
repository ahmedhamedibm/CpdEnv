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

# Make all bash files executable
chmod +x cpd_vars.sh
chmod +x cpd_install.sh
chmod +x requirements.sh

```


### Or

```bash
# Curl the helper script to create the directory ~/cpd_install_env that will contain all needed scripts
curl -sSL https://raw.githubusercontent.com/ahmedhamedibm/CpdEnv/master/cpd_install_helper.sh | bash

# Change directory into ~/cpd_install_env
cd ~/cpd_install_env
```

## Prerequisite
If any of the following tools are not installed, ensure you run the requirements.sh script.
1. ibmcloud command
2. oc command
3. node_reload
4. podman

## Usage
After installation or pulling the repo, if all tools listed in the prerequisite are present you can skip step 1 below.

1. Run the ./requirements.sh and source your profile
```bash
# Run the script to ensure proper cli tools are installed
./requirements.sh

#source to ensure tools can be found.
source ~/.bashrc
```

2. Edit the cpd_vars.sh and input the values appropriate to your cluster. There are comments in the cpd_vars.sh file to guide some of the information needed.

3. Login in to the openshift cluster with your oc login command copied from the openshift console. Example below 
```bash
oc login --token=sha256~LKh9Gqe0db_BrjlUR2L_e84NRNd1c8CgfkqoOimgAQg --server=https://c111-e.us-east.containers.cloud.ibm.com:31969
```
If your openshift cluster is on ibmcloud login and ensure you select the account associated with your openshift cluster.
```bash
ibmcloud login --sso --no-region
```

4. Run the command below based of your environment.
```bash
# If on your local machine run ./cpd_install.sh
./cpd_install.sh
# If you are using a bastion or cloud instance run the command below.
nohup ./cpd_install.sh
```


## Warning

This is for internal use only to simplify the process of installing Cloud Pak for Data using the cpd-cli. It has only been minimally tested on rhel and ubuntu images.
