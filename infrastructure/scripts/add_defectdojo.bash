helm repo add yc-courses-ru-devsecops-helm-charts https://yandex-cloud-examples.github.io/yc-courses-ru-devsecops-helm-charts/
helm repo update

mkdir ~/defectdojo
cd ~/defectdojo

kubectl get svc
#NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
#ingress-nginx-controller             LoadBalancer   10.96.197.87    158.160.166.81   80:31657/TCP,443:31391/TCP   3d22h
#ingress-nginx-controller-admission   ClusterIP      10.96.177.240   <none>           443/TCP                      3d22h
#kubernetes                           ClusterIP      10.96.128.1     <none>           443/TCP                      3d22h

helm install \
    defectdojo \
    --namespace=defectdojo \
    --create-namespace \
    --values ./values-custom.yaml \
    --set createSecret=true \
    --set createRabbitMqSecret=true \
    --set createPostgresqlSecret=true \
    yc-courses-ru-devsecops-helm-charts/defectdojo

echo "DefectDojo admin password: $(kubectl \
    get secret defectdojo \
    --namespace=defectdojo \
    --output jsonpath='{.data.DD_ADMIN_PASSWORD}' |
    base64 --decode)"
