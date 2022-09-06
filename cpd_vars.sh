#===============================================================================
# Cloud Pak for Data installation variables
#===============================================================================

# ------------------------------------------------------------------------------
# Cluster
# ------------------------------------------------------------------------------

# Copy serve from the server portion of oc login command found through the openshift web console
export OCP_URL=<enter your server url>
export OCP_API_SERVER=<enter your server url>

export OPENSHIFT_TYPE=roks
# export OCP_USERNAME=<enter your username>
# export OCP_PASSWORD=<enter your password>

# Copy token from the token portion of oc login command found through the openshift web console
export OCP_TOKEN=<enter your token>


# ------------------------------------------------------------------------------
# Projects
# ------------------------------------------------------------------------------

export PROJECT_CPFS_OPS=ibm-common-services        
export PROJECT_CPD_OPS=ibm-common-services
export PROJECT_CATSRC=openshift-marketplace
export PROJECT_CPD_INSTANCE=cpd-instance
# export PROJECT_TETHERED=<enter the tethered project>


# ------------------------------------------------------------------------------
# Storage
# ------------------------------------------------------------------------------

export STG_CLASS_BLOCK=ibmc-block-gold
export STG_CLASS_FILE=ibmc-file-gold-gid

# ------------------------------------------------------------------------------
# IBM Entitled Registry
# ------------------------------------------------------------------------------

export IBM_ENTITLEMENT_KEY=<enter your IBM entitlement API key>


# ------------------------------------------------------------------------------
# Private container registry
# ------------------------------------------------------------------------------
# Set the following variables if you mirror images to a private container registry.
#
# To export these variables, you must uncomment each command in this section.

# export PRIVATE_REGISTRY_LOCATION=<enter the location of your private container registry>
# export PRIVATE_REGISTRY_PUSH_USER=<enter the username of a user that can push to the registry>
# export PRIVATE_REGISTRY_PUSH_PASSWORD=<enter the password of the user that can push to the registry>
# export PRIVATE_REGISTRY_PULL_USER=<enter the username of a user that can pull from the registry>
# export PRIVATE_REGISTRY_PULL_PASSWORD=<enter the password of the user that can pull from the registry>


# ------------------------------------------------------------------------------
# Cloud Pak for Data version
# ------------------------------------------------------------------------------

export CP4D_VERSION=4.5.2


# ------------------------------------------------------------------------------
# Components
# ------------------------------------------------------------------------------
# Set the following variable if you want to install or upgrade multiple components at the same time.
#
# To export the variable, you must uncomment the command.

export CP4D_OPERATOR_COMPONENTS=cpfs,scheduler,cpd_platform
