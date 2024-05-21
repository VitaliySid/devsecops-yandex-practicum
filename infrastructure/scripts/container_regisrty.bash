kubectl create secret docker-registry gitlab-credentials --docker-server=qwuen.gitlab.yandexcloud.net:5050 --docker-username=qwuen --docker-password=glpat-oJMm_APHLhNrjrBBE2Uv --docker-email=qwuen@yandex.ru -n finenomore

helm repo add gitlab https://charts.gitlab.io
helm repo update
helm upgrade --install finenomore-gitlab-agent gitlab/gitlab-agent \
    --namespace gitlab-agent-finenomore-gitlab-agent \
    --create-namespace \
    --set image.tag=v16.10.1 \
    --set config.token=glagent-DjNmF8HycXc-zXjGETgFJNTon2VB2Nzzx_yGKrTyE6e6x56d7g \
    --set config.kasAddress=wss://qwuen.gitlab.yandexcloud.net/-/kubernetes-agent/

ubuntu@fhmc1tortl691h098sgm $ kubectl get ingress -n finenomore
#NAME         CLASS    HOSTS   ADDRESS          PORTS   AGE
#finenomore   <none>   *       158.160.166.81   80      31h
