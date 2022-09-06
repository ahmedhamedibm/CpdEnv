#1. Install Cpd-cli
. nei --installdep --installcpd

# 1.Source cpd_vars.sh
source cpd_vars.sh

# 2.Login
OCP_API_SERVER=$(oc whoami --show-server=true)
OCP_TOKEN=$(oc whoami -t)
cpd-cli manage login-to-ocp --token=${OCP_TOKEN} --server=${OCP_API_SERVER} || sudo cpd-cli manage login-to-ocp --token=${OCP_TOKEN} --server=${OCP_API_SERVER}

# 3.Apply OLM
cpd-cli manage apply-olm --release=${CP4D_VERSION} --components=${CP4D_OPERATOR_COMPONENTS} || sudo cpd-cli manage apply-olm --release=${CP4D_VERSION} --components=${CP4D_OPERATOR_COMPONENTS}

# 4.Patch OLM
oc patch NamespaceScope common-service \
    -n ${PROJECT_CPD_OPS} \
    --type=merge \
    --patch='{"spec": {"csvInjector": {"enable": true} } }'

# 5.Apply Custom Resource
cpd-cli manage apply-cr --components=${CP4D_OPERATOR_COMPONENTS} --release=${CP4D_VERSION} --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --block_storage_class=${STG_CLASS_BLOCK} --file_storage_class=${STG_CLASS_FILE} --license_acceptance=true \
|| sudo cpd-cli manage apply-cr --components=${CP4D_OPERATOR_COMPONENTS} --release=${CP4D_VERSION} --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --block_storage_class=${STG_CLASS_BLOCK} --file_storage_class=${STG_CLASS_FILE} --license_acceptance=true

# 6. Get Console Info
oc get ZenService lite-cr -n ${PROJECT_CPD_INSTANCE} -o jsonpath="{.status.url}{'\n'}"
oc extract secret/admin-user-details --keys=initial_admin_password --to=- -n ${PROJECT_CPD_INSTANCE}