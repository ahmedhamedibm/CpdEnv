server_info(){

    export DISTRO=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om || echo "")
    export ARCHITECTURE=$(uname -m)
    export BITS=$(getconf LONG_BIT)
    
    }
server_info


if [[ -z "$(type -P nei)" ]]; then
    if [[ "$DISTRO" == *Ubuntu* || "$DISTRO" == *Debian* || "$DISTRO" == *RED*HAT* || "$DISTRO" == *RHEL* || "$DISTRO" == *CentOS* || "$DISTRO" == Fedora  || "$DISTRO" == *Red*Hat*Enterprise*Linux* ]]; then
        wget https://github.com/IBM/cpd-cli/releases/download/v11.2.0/cpd-cli-linux-EE-11.2.0.tgz || sudo wget https://github.com/IBM/cpd-cli/releases/download/v11.2.0/cpd-cli-linux-EE-11.2.0.tgz
        tar -zxvf cpd-cli-linux-EE-11.2.0.tgz || sudo tar -zxvf cpd-cli-linux-EE-11.2.0.tgz
        rm -rf cpd-cli-linux-EE-11.2.0.tgz || sudo rm -rf cpd-cli-linux-EE-11.2.0.tgz
        mv cpd-cli-linux-EE-11.2.0-40 $HOME/bin/ || sudo mv cpd-cli-linux-EE-11.2.0-40 $HOME/bin/
        echo 'export PATH=$PATH":$HOME/bin/cpd-cli-linux-EE-11.2.0-40"' >> ~/.bashrc || sudo echo 'export PATH=$PATH":$HOME/bin/cpd-cli-linux-EE-11.2.0-40"' >> ~/.bashrc
        source ~/.bashrc
    else
        wget https://github.com/IBM/cpd-cli/releases/download/v11.2.0/cpd-cli-darwin-EE-11.2.0.tgz || sudo wget https://github.com/IBM/cpd-cli/releases/download/v11.2.0/cpd-cli-darwin-EE-11.2.0.tgz
        tar -zxvf cpd-cli-darwin-EE-11.2.0.tgz || sudo tar -zxvf cpd-cli-darwin-EE-11.2.0.tgz
        rm -rf cpd-cli-darwin-EE-11.2.0.tgz || sudo rm -rf cpd-cli-darwin-EE-11.2.0.tgz
        mv cpd-cli-darwin-EE-11.2.0-40 $HOME/bin/ || sudo mv cpd-cli-darwin-EE-11.2.0-40 $HOME/bin/
        echo 'export PATH=$PATH":$HOME/bin/cpd-cli-darwin-EE-11.2.0-40"' >> ~/.zshrc || sudo echo 'export PATH=$PATH":$HOME/bin/cpd-cli-darwin-EE-11.2.0-40"' >> ~/.zshrc
        source ~/.zshrc
    fi
else
    . nei --installdep --installcpd --installpodman --installibmc
fi

curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash

if [[ -z "$(type -P oc)" ]] && [[ -z "$(type -P nei)" ]]; then
    if [[ "$DISTRO" == *Ubuntu* || "$DISTRO" == *Debian* || "$DISTRO" == *RED*HAT* || "$DISTRO" == *RHEL* || "$DISTRO" == *CentOS* || "$DISTRO" == Fedora  || "$DISTRO" == *Red*Hat*Enterprise*Linux* ]]; then
        wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -P /usr/local/bin || sudo wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -P /usr/local/bin
        tar xvzf /usr/local/bin/openshift*.tar.gz -C /usr/local/bin || sudo tar xvzf /usr/local/bin/openshift*.tar.gz -C /usr/local/bin
        if [[ -a /usr/local/bin/oc ]]; then
            chmod +x /usr/local/bin/oc || sudo chmod +x /usr/local/bin/oc
            echo "alias oc='/usr/local/bin/oc'" >> ~/.bashrc || sudo echo "alias oc='/usr/local/bin/oc'" >> ~/.bashrc
        else
            echo "/usr/local/bin/oc not found"
        fi
    elif [[ ${ARCHITECTURE} == arm64 || ${ARCHITECTURE} == Arm64 ]]; then
        wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-mac-arm64.tar.gz -P /usr/local/bin || sudo wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-mac-arm64.tar.gz -P /usr/local/bin
        tar xvzf /usr/local/bin/openshift*.tar.gz -C /usr/local/bin || sudo tar xvzf /usr/local/bin/openshift*.tar.gz -C /usr/local/bin
        if [[ -a /usr/local/bin/oc ]]; then
            chmod +x /usr/local/bin/oc || sudop chmod +x /usr/local/bin/oc
            echo "alias oc='/usr/local/bin/oc'" >> ~/.zshrc || sudo echo "alias oc='/usr/local/bin/oc'" >> ~/.zshrc
        else
            echo "/usr/local/bin/oc not found"
        fi
        if [[ -z "$(which oc)" ]]; then
            brew install openshift-cli || brew upgrade openshift-cli || sudo brew install openshift-cli ||sudo brew upgrade openshift-cli
        fi
    else
        wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-mac.tar.gz -P /usr/local/bin || sudo wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-mac.tar.gz -P /usr/local/bin
        tar xvzf /usr/local/bin/openshift*.tar.gz -C /usr/local/bin || sudo tar xvzf /usr/local/bin/openshift*.tar.gz -C /usr/local/bin
        if [[ -a /usr/local/bin/oc ]]; then
            chmod +x /usr/local/bin/oc || sudo chmod +x /usr/local/bin/oc
            echo "alias oc='/usr/local/bin/oc'" >> ~/.zshrc || sudo echo "alias oc='/usr/local/bin/oc'" >> ~/.zshrc
        else
            echo "/usr/local/bin/oc not found"
        fi
        if [[ -z "$(which oc)" ]]; then
            brew install openshift-cli || brew upgrade openshift-cli || sudo brew install openshift-cli || sudo brew upgrade openshift-cli
        fi
    fi
else [[ -n "$(type -P nei)" ]];
    . nei --installoc
fi
