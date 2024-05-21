# profile list
yc config profile list
yc config profile get default

# get kube config
yc managed-kubernetes cluster get-credentials --name=k8s-master --external

# install ingress
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx

# get balancer ip
yc load-balancer network-load-balancer list
# +----------------------+----------------------------------------------+-------------+----------+----------------+------------------------+--------+
# |          ID          |                     NAME                     |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
# +----------------------+----------------------------------------------+-------------+----------+----------------+------------------------+--------+
# | enpe0blue1hubpcs5q8o | k8s-53d886b89cad4b6062cbfa038be32b80d06c7d12 | ru-central1 | EXTERNAL |              2 | enp2g3t6omge1lv4uq7c   | ACTIVE |
# +----------------------+----------------------------------------------+-------------+----------+----------------+------------------------+--------+

yc load-balancer network-load-balancer get enp2g3t6omge1lv4uq7c | grep address

# stopping instances

yc managed-kubernetes cluster stop k8s-master
yc compute instance stop --id id
