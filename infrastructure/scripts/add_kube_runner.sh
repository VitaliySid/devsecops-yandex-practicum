helm repo add gitlab https://charts.gitlab.io

helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
kubectl get pods -n default | grep gitlab-runner

# update with Kaniko
helm upgrade --install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
