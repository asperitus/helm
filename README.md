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


#bitcoin

helm install --namespace ln --name bitcoin -f ./lightningd/bitcoind-values.yaml stable/bitcoind

#lightning/charge

helm install --namespace ln --name lightning ./lightningd

#postgres
helm install --namespace ln --name postgres stable/postgresql \
    --set nameOverride=db \
    --set postgresqlUsername=postgres \
    --set postgresqlPassword=secretPassword \
    --set postgresqlDatabase=btcpayserver
    
#btcpay/nbxplorer
helm install --namespace ln --name btcpay ./btcpayd

#mariadb
helm install --namespace store --name mysql stable/mariadb \
    --set nameOverride=db \
    --set rootUser.password=secretPassword \
    --set db.user=mysql \
    --set db.password=secretPassword

<!-- my_database -->
<!-- --set db.name=storefront privileges not granted -->
    
kubectl -n store exec -i -t mysql-mariadb-master-0 -- mysql -uroot --password=secretPassword

#wordpress/woocommerce
helm install --namespace store --name wordpress stable/wordpress \
    --set serviceType=LoadBalancer \
    --set wordpressUsername=admin \
    --set wordpressPassword=password \
    --set mariadb.enabled=false \
    --set externalDatabase.host=mysql-db \
    --set externalDatabase.port=3306 \
    --set externalDatabase.user=mysql \
    --set externalDatabase.password=secretPassword \
    --set externalDatabase.database=my_database

<!-- docker run -it --rm --entrypoint "/bin/bash" elementsproject/lightningd -->
<!-- docker run -it --rm --entrypoint "/usr/bin/lightning-cli" elementsproject/lightningd --help -->

<!-- kubectl exec -i -t -n ln $POD -- bash -->

#dashboard
kubectl proxy

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/