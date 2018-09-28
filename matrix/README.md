
server:

helm install --namespace matrix --name matrix asperitus/matrix \
    --set service.type=LoadBalancer \
    --set service.port=80

export SERVICE_IP=$(kubectl get svc --namespace matrix matrix -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export MATRIX_URL=http://$SERVICE_IP:80/tunnel

service:

helm install --namespace matrix --name matrix-service asperitus/matrix \
    --set matrix.command=service \
    --set matrix.url=$MATRIX_URL \
    --set matrix.service=vm,matrix.hostport=

connect:

helm install --namespace matrix --name matrix-connect asperitus/matrix \
    --set matrix.command=connect \
    --set matrix.url=$MATRIX_URL \
    --set matrix.service=vm
