# helm
Kubernetes Helm charts

Add charts repository:

helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm repo add asperitus https://asperitus.github.io/helm


Create namespace:

kubectl create namespace dsp


Zookeeper:

helm install --namespace dsp --name zookeeper incubator/zookeeper \
      --set replicaCount=1 \
      --set fullnameOverride=zookeeper

Nifi:

helm install --namespace dsp --name nifi asperitus/nifi