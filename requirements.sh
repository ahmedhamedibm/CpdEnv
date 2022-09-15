server_info(){

    export DISTRO=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om || echo "")
    export ARCHITECTURE=$(uname -m)
    export BITS=$(getconf LONG_BIT)
    
    }
server_info


# DEPENDENCIES 
install_deps(){
    
    if [[ "$DISTRO" == *Ubuntu* || "$DISTRO" == *Debian* ]]; then
        apt-get update -y || sudo apt-get update -y
        apt-get install -y apt-utils || sudo apt-get install -y apt-utils
        apt-get -y upgrade || sudo apt-get -y upgrade
        apt-get install -y snap software-properties-common apt-transport-https wget curl unzip vim iproute2 git jq python3.6 || sudo apt-get install -y snap software-properties-common apt-transport-https wget curl unzip vim iproute2 git jq python3.6
    elif [[ "$DISTRO" == *RED*HAT* || "$DISTRO" == *RHEL* || "$DISTRO" == *CentOS* || "$DISTRO" == Fedora  || "$DISTRO" == *Red*Hat*Enterprise*Linux* ]]; then
        yum update -y || sudo yum update -y
        dnf update -y || sudo dnf update -y
        yum install -y wget curl unzip python36 vim git jq || sudo yum install -y wget curl unzip python36 vim jq || dnf install -y wget curl unzip python36 vim git jq || sudo dnf install -y wget curl unzip python36 vim jq
    else 
        if [[ -z "$(which brew)" && -n "$(which ruby)" ]]; then   
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install jq || sudo brew install jq
    fi
}

# PODMAN
install_podman(){
    if [[ "$DISTRO" == *Ubuntu* || "$DISTRO" == *Debian* ]]; then
        apt-get install -y podman || sudo apt-get install -y podman
        if [[ -z "$(type -P podman)" ]]; then
            source /etc/os-release
            sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list" || sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
            wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | apt-key add - || sudo wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
            apt -y update || sudo apt -y update
            apt -y install podman || sudo apt -y install podman
        fi
    elif [[ "$DISTRO" == *RED*HAT* || "$DISTRO" == *RHEL* || "$DISTRO" == *CentOS* || "$DISTRO" == Fedora  || "$DISTRO" == *Red*Hat*Enterprise*Linux* ]]; then
        dnf -y install podman || yum -y install podman || sudo dnf install podman || sudo yum install podman
        if [[ -z "$(type -P podman)" ]]; then
            dnf config-manager --set-enabled powertools || sudo dnf config-manager --set-enabled powertools
            dnf -y update || sudo dnf -y update
            dnf install -y @container-tools  || sudo dnf install -y @container-tools 
        fi
    else 
        brew install podman || sudo brew install podman
        podman machine init || sudo podman machine init
        podman machine start || sudo podman machine start
    fi

}

# OC CLI
install_oc(){
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
}

# IBM CLOUD CLI FUNCTION
install_ibmc() {
    curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash 
}

# Install Northeast nod reload tool
install_node_reload(){
    curl -ssl https://raw.github.ibm.com/National-Northeast-1/Node-Reloader/main/node_reload_helper.sh?token=AACTOHMQTLK6NEG6HPZPSTLDETUE4 | bash || sudo curl -ssl https://raw.github.ibm.com/National-Northeast-1/Node-Reloader/main/node_reload_helper.sh?token=AACTOHMQTLK6NEG6HPZPSTLDETUE4 | bash
    source ~/.bashrc || sudo source ~/.bashrc || source ~/.zshrc || sudo source ~/.zshrc   
}

# Cpd CLi
install_cpd_cli(){
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

}

if [[ -z "$(type -P podman)" ]] || [[ -z "$(type -P oc)" ]] || [[ -z "$(type -P ibmcloud)" ]] || [[ -z "$(type -P node_reload)" ]] || [[ -z "$(type -P cpd-cli)" ]]; then
    install_deps
else
    exit
fi

if [[ -z "$(type -P podman)" ]]; then
    install_podman
fi

if [[ -z "$(type -P oc)" ]]; then
    install_oc
fi

if [[ -z "$(type -P ibmcloud)" ]]; then
    install_ibmc
fi

if [[ -z "$(type -P node_reload)" ]]; then
    install_node_reload
fi

if [[ -z "$(type -P cod-cli)" ]]; then
    install_cpd_cli
fi
