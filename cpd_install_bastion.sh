# Set color
BIBlue='\033[1;94m'
NC='\033[0m'

#1. Install Cpd-cli
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
        echo "export PATH=$PWD/cpd-cli-linux-EE-11.2.0-40:$PATH" >> ~/.bashrc || sudo echo "export PATH=$PWD/cpd-cli-linux-EE-11.2.0-40:$PATH" >> ~/.bashrc
        source ~/.bashrc
    else
        wget https://github.com/IBM/cpd-cli/releases/download/v11.2.0/cpd-cli-darwin-EE-11.2.0.tgz || sudo wget https://github.com/IBM/cpd-cli/releases/download/v11.2.0/cpd-cli-darwin-EE-11.2.0.tgz
        tar -zxvf cpd-cli-darwin-EE-11.2.0.tgz || sudo tar -zxvf cpd-cli-darwin-EE-11.2.0.tgz
        rm -rf cpd-cli-darwin-EE-11.2.0.tgz || sudo rm -rf cpd-cli-darwin-EE-11.2.0.tgz
        echo "export PATH=$PWD/cpd-cli-darwin-EE-11.2.0-40:$PATH" >> ~/.bashrc || sudo echo "export PATH=$PWD/cpd-cli-darwin-EE-11.2.0-40:$PATH" >> ~/.bashrc
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

# 1.Source cpd_vars.sh
source ./cpd_vars.sh

# 2.Login
OCP_API_SERVER=$(oc whoami --show-server=true)
OCP_TOKEN=$(oc whoami -t)
echo -e "${BIBlue}cpd-cli manage login-to-ocp${NC}"
nohup cpd-cli manage login-to-ocp --token=${OCP_TOKEN} --server=${OCP_API_SERVER}

# 3.Apply OLM
echo -e "${BIBlue}cpd-cli manage apply-olm${NC}"
nohup cpd-cli manage apply-olm --release=${CP4D_VERSION} --components=${CP4D_OPERATOR_COMPONENTS}

# 4.Update pull secret
nohup cpd-cli manage add-icr-cred-to-global-pull-secret ${IBM_ENTITLEMENT_KEY}

# 5.Create DaemonSet to Update Secret
cat <<EOF |oc apply -f -
---
kind: Project
apiVersion: project.openshift.io/v1
metadata:
  name: tools
---
# Source: global-pull-secret-synch/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: global-pull-secret-synch-config
  namespace: tools
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
data:
  global-pull-secret-sync.sh: |
    #!/bin/bash

    while true
    do
      BLOCKLIST='["cloud.openshift.com","quay.io","registry.connect.redhat.com","registry.redhat.io"]'
      #echo "BLOCKLIST=$BLOCKLIST"
      echo "Synchronize docker config: $(date +"%T")"

      #ls -la /host
      #cat /host/.docker/config.json

      cp /host/.docker/config.json /host/.docker/config.json.backup

      oc extract secret/pull-secret \
        -n openshift-config

      jq -rc '.auths | keys[]' .dockerconfigjson | while read key; do

        #echo $key
        FOUND=$(echo "$BLOCKLIST" | jq -e '.[]|select(. == "'$key'")')

        # if not found in blocklist, then process the key
        if [ -z $FOUND ]; then
          echo "Processing \"$key\""

          VALUE=$(jq -cr ".auths.\"$key\"" .dockerconfigjson)

          cat /host/.docker/config.json | jq '.auths += {"'$key'":'$VALUE'}' > /host/.docker/config.json.tmp
          mv /host/.docker/config.json.tmp /host/.docker/config.json
        fi
      done

      rm -rf .dockerconfigjson

      sleep 5m
    done
---
# Source: global-pull-secret-synch/templates/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: global-pull-secret-synch-role
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    resourceNames: ["pull-secret"]
    verbs: ["*"]
---
# Source: global-pull-secret-synch/templates/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: global-pull-secret-synch-rb
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
subjects:
  - kind: ServiceAccount
    name: global-pull-secret-synch-sa
    namespace: openshift-config
  - kind: ServiceAccount
    name: global-pull-secret-synch-sa
    namespace: tools
roleRef:
  kind: ClusterRole
  name: global-pull-secret-synch-role
  apiGroup: rbac.authorization.k8s.io
---
# Source: global-pull-secret-synch/templates/daemonset.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: global-pull-secret-synch-ds
  namespace: tools
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: global-pull-secret-synch
      app.kubernetes.io/instance: global-pull-secret-synch
  template:
    metadata:
      labels:
        helm.sh/chart: global-pull-secret-synch-0.1.0
        app.kubernetes.io/name: global-pull-secret-synch
        app.kubernetes.io/instance: global-pull-secret-synch
        app.kubernetes.io/version: "1.16.0"
        app.kubernetes.io/managed-by: Helm
    spec:
      serviceAccountName: global-pull-secret-synch-sa
      securityContext:
        {}
      terminationGracePeriodSeconds: 60
      volumes:
        - name: scripts
          configMap:
            name: global-pull-secret-synch-config
            defaultMode: 0777
        - hostPath:
            path: /
            type: Directory
          name: host
      containers:
        - name:  global-pull-secret-synch
          image: "quay.io/ibmgaragecloud/cli-tools:latest"
          securityContext:
            privileged: true
          volumeMounts:
            - mountPath: /scripts
              name: scripts
            - mountPath: /host
              name: host
          env:
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
          command:
            - /scripts/global-pull-secret-sync.sh
---
# Source: global-pull-secret-synch/charts/service-account/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  namespace: tools
  name: global-pull-secret-synch-sa
  namespace: tools
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "-5"
  labels:
    helm.sh/chart: service-account-0.6.1
    app.kubernetes.io/name: global-pull-secret-synch-sa
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
---
# Source: global-pull-secret-synch/charts/service-account/templates/scc-privileged.yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "-3"
    argocd.argoproj.io/sync-options: Validate=false
    kubernetes.io/description: 'privileged allows access to all privileged and host
      features and the ability to run as any user, any group, any fsGroup, and with
      any SELinux context.  WARNING: this is the most relaxed SCC and should be used
      only for cluster administration. Grant with caution.'
  name: tools-global-pull-secret-synch-sa-privileged
  labels:
    helm.sh/chart: service-account-0.6.1
    app.kubernetes.io/name: global-pull-secret-synch-sa
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
allowHostDirVolumePlugin: true
allowHostIPC: true
allowHostNetwork: true
allowHostPID: true
allowHostPorts: true
allowPrivilegeEscalation: true
allowPrivilegedContainer: true
allowedCapabilities:
  - '*'
allowedUnsafeSysctls:
  - '*'
defaultAddCapabilities: null
fsGroup:
  type: RunAsAny
groups:
  - system:cluster-admins
  - system:nodes
  - system:masters
priority: null
readOnlyRootFilesystem: false
requiredDropCapabilities: null
runAsUser:
  type: RunAsAny
seLinuxContext:
  type: RunAsAny
seccompProfiles:
  - '*'
supplementalGroups:
  type: RunAsAny
users:
  - system:serviceaccount:tools:global-pull-secret-synch-sa
volumes:
  - '*'
EOF

# 6.Patch OLM
echo -e "${BIBlue}oc patch NamespaceScope${NC}"
oc patch NamespaceScope common-service \
    -n ${PROJECT_CPD_OPS} \
    --type=merge \
    --patch='{"spec": {"csvInjector": {"enable": true} } }'

# 7.Apply Custom Resource
echo -e "${BIBlue}cpd-cli manage apply-cr${NC}"
nohup cpd-cli manage apply-cr --components=${CP4D_OPERATOR_COMPONENTS} --release=${CP4D_VERSION} --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --block_storage_class=${STG_CLASS_BLOCK} --file_storage_class=${STG_CLASS_FILE} --license_acceptance=true 

# 8. Delete Pull Secret DaemonSet
cat <<EOF |oc delete -f -
---
kind: Project
apiVersion: project.openshift.io/v1
metadata:
  name: tools
---
# Source: global-pull-secret-synch/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: global-pull-secret-synch-config
  namespace: tools
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
data:
  global-pull-secret-sync.sh: |
    #!/bin/bash

    while true
    do
      BLOCKLIST='["cloud.openshift.com","quay.io","registry.connect.redhat.com","registry.redhat.io"]'
      #echo "BLOCKLIST=$BLOCKLIST"
      echo "Synchronize docker config: $(date +"%T")"

      #ls -la /host
      #cat /host/.docker/config.json

      cp /host/.docker/config.json /host/.docker/config.json.backup

      oc extract secret/pull-secret \
        -n openshift-config

      jq -rc '.auths | keys[]' .dockerconfigjson | while read key; do

        #echo $key
        FOUND=$(echo "$BLOCKLIST" | jq -e '.[]|select(. == "'$key'")')

        # if not found in blocklist, then process the key
        if [ -z $FOUND ]; then
          echo "Processing \"$key\""

          VALUE=$(jq -cr ".auths.\"$key\"" .dockerconfigjson)

          cat /host/.docker/config.json | jq '.auths += {"'$key'":'$VALUE'}' > /host/.docker/config.json.tmp
          mv /host/.docker/config.json.tmp /host/.docker/config.json
        fi
      done

      rm -rf .dockerconfigjson

      sleep 5m
    done
---
# Source: global-pull-secret-synch/templates/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: global-pull-secret-synch-role
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    resourceNames: ["pull-secret"]
    verbs: ["*"]
---
# Source: global-pull-secret-synch/templates/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: global-pull-secret-synch-rb
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
subjects:
  - kind: ServiceAccount
    name: global-pull-secret-synch-sa
    namespace: openshift-config
  - kind: ServiceAccount
    name: global-pull-secret-synch-sa
    namespace: tools
roleRef:
  kind: ClusterRole
  name: global-pull-secret-synch-role
  apiGroup: rbac.authorization.k8s.io
---
# Source: global-pull-secret-synch/templates/daemonset.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: global-pull-secret-synch-ds
  namespace: tools
  labels:
    helm.sh/chart: global-pull-secret-synch-0.1.0
    app.kubernetes.io/name: global-pull-secret-synch
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: global-pull-secret-synch
      app.kubernetes.io/instance: global-pull-secret-synch
  template:
    metadata:
      labels:
        helm.sh/chart: global-pull-secret-synch-0.1.0
        app.kubernetes.io/name: global-pull-secret-synch
        app.kubernetes.io/instance: global-pull-secret-synch
        app.kubernetes.io/version: "1.16.0"
        app.kubernetes.io/managed-by: Helm
    spec:
      serviceAccountName: global-pull-secret-synch-sa
      securityContext:
        {}
      terminationGracePeriodSeconds: 60
      volumes:
        - name: scripts
          configMap:
            name: global-pull-secret-synch-config
            defaultMode: 0777
        - hostPath:
            path: /
            type: Directory
          name: host
      containers:
        - name:  global-pull-secret-synch
          image: "quay.io/ibmgaragecloud/cli-tools:latest"
          securityContext:
            privileged: true
          volumeMounts:
            - mountPath: /scripts
              name: scripts
            - mountPath: /host
              name: host
          env:
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
          command:
            - /scripts/global-pull-secret-sync.sh
---
# Source: global-pull-secret-synch/charts/service-account/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  namespace: tools
  name: global-pull-secret-synch-sa
  namespace: tools
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "-5"
  labels:
    helm.sh/chart: service-account-0.6.1
    app.kubernetes.io/name: global-pull-secret-synch-sa
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
---
# Source: global-pull-secret-synch/charts/service-account/templates/scc-privileged.yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "-3"
    argocd.argoproj.io/sync-options: Validate=false
    kubernetes.io/description: 'privileged allows access to all privileged and host
      features and the ability to run as any user, any group, any fsGroup, and with
      any SELinux context.  WARNING: this is the most relaxed SCC and should be used
      only for cluster administration. Grant with caution.'
  name: tools-global-pull-secret-synch-sa-privileged
  labels:
    helm.sh/chart: service-account-0.6.1
    app.kubernetes.io/name: global-pull-secret-synch-sa
    app.kubernetes.io/instance: global-pull-secret-synch
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
allowHostDirVolumePlugin: true
allowHostIPC: true
allowHostNetwork: true
allowHostPID: true
allowHostPorts: true
allowPrivilegeEscalation: true
allowPrivilegedContainer: true
allowedCapabilities:
  - '*'
allowedUnsafeSysctls:
  - '*'
defaultAddCapabilities: null
fsGroup:
  type: RunAsAny
groups:
  - system:cluster-admins
  - system:nodes
  - system:masters
priority: null
readOnlyRootFilesystem: false
requiredDropCapabilities: null
runAsUser:
  type: RunAsAny
seLinuxContext:
  type: RunAsAny
seccompProfiles:
  - '*'
supplementalGroups:
  type: RunAsAny
users:
  - system:serviceaccount:tools:global-pull-secret-synch-sa
volumes:
  - '*'
EOF

# 9. Get Console Info
echo -e "${BIBlue}Console Info:${NC}"
cpd-cli manage get-cpd-instance-details --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --get_admin_initial_credentials=true