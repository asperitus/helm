# helm

<!-- 
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm init --service-account tiller --upgrade
-->

### add charts repository:

<!-- helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator -->
```
helm repo add asperitus https://asperitus.github.io/helm
```

<!--
create namespace:

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
-->

<!-- ### nifi

```
helm install --namespace fe --name nifi ./nifi \
    --set replicaCount=1 \
    --set zookeeper.enabled=false \
    --set zookeeper.url=zookeeper:2181
``` -->

### bitcoin

```
helm install --namespace ln --name bitcoin -f ./bitcoind/values.yaml stable/bitcoind
```

### lightning/charge

```
helm install --namespace ln --name lightning asperitus/lightningd \
    --set persistence.size=10Gi
```

### postgres

```
helm install --namespace db --name postgres stable/postgresql \
    --set nameOverride=db \
    --set postgresqlUsername=postgres \
    --set postgresqlPassword=secretPassword \
    --set postgresqlDatabase=btcpayserver
 ```

<!--
PostgreSQL can be accessed via port 5432 on the following DNS name from within your cluster:

    postgres-db.db.svc.cluster.local

To get the password for "postgres" run:

    export POSTGRESQL_PASSWORD=$(kubectl get secret --namespace db postgres-db -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run postgres-db-client --rm --tty -i --image bitnami/postgresql --env="PGPASSWORD=$POSTGRESQL_PASSWORD" --command -- psql --host postgres-db -U postgres



To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace db svc/postgres-db 5432:5432 &
    PGPASSWORD=secretPassword "psql --host 127.0.0.1 -U postgres
-->

### mariadb
```
helm install --namespace db --name mysql stable/mariadb \
    --set nameOverride=db \
    --set service.port=3306 \
    --set rootUser.password=secretPassword \
    --set db.user=mysql \
    --set db.password=secretPassword
```

<!--
Administrator credentials:

  Username: root
  Password : $(kubectl get secret --namespace db mysql-db -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)

To connect to your database:

  1. Run a pod that you can use as a client:

      kubectl run mysql-db-client --rm --tty -i --image  docker.io/bitnami/mariadb:10.1.36 --namespace db --command -- bash

  2. To connect to master service (read/write):

      mysql -h mysql-db.db.svc.cluster.local -uroot -p my_database

  3. To connect to slave service (read-only):

      mysql -h mysql-mariadb-slave.db.svc.cluster.local -uroot -p my_database

To upgrade this helm chart:

  1. Obtain the password as described on the 'Administrator credentials' section and set the 'rootUser.password' parameter as shown below:

      ROOT_PASSWORD=$(kubectl get secret --namespace db mysql-db -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)
      helm upgrade mysql stable/mariadb --set rootUser.password=$ROOT_PASSWORD
-->

<!-- my_database -->
<!-- --set db.name=storefront privileges not granted -->
<!-- kubectl -n store exec -i -t mysql-mariadb-master-0 -- mysql -uroot --password=secretPassword -->

### btcpay/nbxplorer

```
export URL=https://btcpay.run.aws-usw02-pr.ice.predix.io/

helm install --namespace ln --name btcpay asperitus/btcpayd \
    --set persistence.size=2Gi \
    --set args.network=testnet \
    --set args.externalUrl=$URL \
    --set foregate.enabled=false \
    --set foregate.port=5080 \
    --set foregate.url=$URL \
    --set foregate.proxy=$http_proxy
```
<!-- 
helm upgrade btcpay asperitus/btcpayd \
    --set service.type=LoadBalancer \
    --set persistence.size=2Gi \
    --set args.network=testnet \
    --set args.externalUrl=https://jixupay.run.aws-usw02-pr.ice.predix.io/ \
    --set foregate.enabled=false \
    --set foregate.port=5080 \
    --set foregate.url=$URL \
    --set foregate.proxy=$http_proxy \
    --recreate-pods --dry-run
-->

<!--
helm upgrade btcpay ./btcpayd --set args.externalUrl=http://localhost:23001/
helm upgrade btcpay ./btcpayd --set args.externalUrl=https://btcpay.run.aws-usw02-pr.ice.predix.io/ 
-->

### wordpress/woocommerce

```
export URL=https://btcpay.run.aws-usw02-pr.ice.predix.io/

helm install --namespace store --name wordpress asperitus/wordpress \
    --set nameOverride=store \
    --set serviceType=ClusterIP \
    --set wordpressUsername=admin \
    --set wordpressPassword=password \
    --set mariadb.enabled=false \
    --set externalDatabase.host=mysql-db.db \
    --set externalDatabase.port=3306 \
    --set externalDatabase.user=mysql \
    --set externalDatabase.password=secretPassword \
    --set externalDatabase.database=my_database \
    --set foregate.enabled=false \
    --set foregate.port=5080 \
    --set foregate.url=$URL \
    --set foregate.proxy=$http_proxy
```

<!-- 
helm upgrade wordpress asperitus/wordpress \
    --set nameOverride=store \
    --set serviceType=LoadBalancer \
    --set wordpressUsername=admin \
    --set wordpressPassword=password \
    --set mariadb.enabled=false \
    --set externalDatabase.host=mysql-db.db \
    --set externalDatabase.port=3306 \
    --set externalDatabase.user=mysql \
    --set externalDatabase.password=secretPassword \
    --set externalDatabase.database=my_database \
    --set foregate.enabled=false \
    --set foregate.port=5080 \
    --set foregate.url=$URL \
    --set foregate.proxy=$http_proxy \
    --recreate-pods --dry-run
-->

### foregate

```
export URL=https://btcpay.run.aws-usw02-pr.ice.predix.io/

helm install --namespace store --name wordpress-foregate asperitus/foregate \
    --set foregate.port=5080 \
    --set foregate.url=$URL \
    --set foregate.hostport=wordpress-store:80 \
    --set foregate.proxy=$http_proxy
```

<!--
helm install --namespace fg --name jixupay asperitus/foregate \
    --set foregate.port=5080 \
    --set foregate.url=https://jixupay.run.aws-usw02-pr.ice.predix.io/ \
    --set foregate.hostport=btcpayd.ln:23001 \
    --set foregate.proxy=$http_proxy

helm upgrade jixupay asperitus/foregate \
    --set foregate.port=5080 \
    --set foregate.url=https://jixupay.run.aws-usw02-pr.ice.predix.io/ \
    --set foregate.hostport=btcpayd.ln:23001 \
    --set foregate.proxy=$http_proxy \
    --recreate-pods

helm install --namespace fg --name jixustore asperitus/foregate \
    --set foregate.port=5080 \
    --set foregate.url=https://jixustore.run.aws-usw02-pr.ice.predix.io/ \
    --set foregate.hostport=wordpress-store.store:80 \
    --set foregate.proxy=$http_proxy

helm upgrade jixustore asperitus/foregate \
    --set foregate.port=5080 \
    --set foregate.url=https://jixustore.run.aws-usw02-pr.ice.predix.io/ \
    --set foregate.hostport=wordpress-store.store:80 \
    --set foregate.proxy=$http_proxy \
    --recreate-pods
-->

### dashboard

```
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl proxy

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

```


<!--  -->
<!-- docker run -it --rm --entrypoint "/bin/bash" elementsproject/lightningd -->
<!-- docker run -it --rm --entrypoint "/usr/bin/lightning-cli" elementsproject/lightningd --help -->
<!-- kubectl exec -i -t -n ln $POD -- bash -->
