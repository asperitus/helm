# helm
Kubernetes Helm charts

Add charts repository:

helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm repo add asperitus https://asperitus.github.io/helm


Create namespace:

kubectl create namespace fe


zookeeper:

helm install --namespace fe --name zookeeper incubator/zookeeper \
      --set replicaCount=1 \
      --set fullnameOverride=zookeeper

nifi:

helm install --namespace fe --name nifi asperitus/nifi

helm install --namespace fe --name nifi asperitus/nifi \
    --set replicaCount=1 \
    --set zookeeper.enabled=false \
    --set zookeeper.url=zookeeper:2181

#local repo
helm install --namespace fe --name nifi ./nifi \
    --set replicaCount=1 \
    --set zookeeper.enabled=false \
    --set zookeeper.url=zookeeper:2181