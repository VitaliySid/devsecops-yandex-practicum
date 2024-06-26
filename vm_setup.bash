#!/bin/bash

# ############################
# YC Toolbox user setup script
# ############################

# Change user prompt
echo "Change user prompt"
echo 'export PS1="\[\033[38;5;245m\]\t:[\w]\[\e[0;0m\]\n\[\033[38;5;50m\]\u\[\e[0;0m\]@\[\033[38;5;48m\]\h\[\e[0;0m\] \\$ "' >>~/.bashrc

# Helm add default repo
echo "Add default Helm repo"
helm repo add stable https://charts.helm.sh/stable

# Terraform config
echo "Configuring Terraform"
cp /usr/local/etc/terraform.rc $HOME/.terraformrc

# Docker
echo "Grant user access to the Docker"
sudo usermod -aG docker ${USER}

# kubectl
echo "Kubectl auto-completion"
cat <<EOF >>$HOME/.bashrc
# kubectl
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
EOF

# YC CLI
VM_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Test the SA presence
folder_id=$(yc compute instance get $VM_ID >/dev/null 2>&1)
if [ $? == 0 ]; then # SA was associated with VM - configure YC via SA
    echo "YC configuration via SA"
    FOLDER_ID=$(yc compute instance get $VM_ID --format=json | jq -r .folder_id)
    CLOUD_ID=$(yc resource folder get $FOLDER_ID --format=json | jq -r .cloud_id)
    yc config profile create default
    yc config set cloud-id $CLOUD_ID
    yc config set folder-id $FOLDER_ID
    unset CLOUD_ID FOLDER_ID VM_ID

# SA was not found - configure YC from the scratch
else
    echo "YC configuration via Init"
    yc init
fi

# Save YC params
echo "Save YC params to the ~/.bashrc"
cat <<EOF >>$HOME/.bashrc
# YC config
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
export YC_TOKEN=\$(yc iam create-token)
EOF

PUB_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4/)
echo -e "\nPlease connnect via ssh again:"
echo -e "ssh ${USER}@${PUB_IP}\n"

pkill -KILL -u ${USER}
