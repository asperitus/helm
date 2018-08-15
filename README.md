# helm

### add charts repository

<!-- - helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator -->

```helm repo add asperitus https://asperitus.github.io/helm```

<!--
--ca-file=/usr/local/etc/openssl/cert.pem
--ca-file=/etc/ssl/certs/ca-bundle.crt
-->

<!-- Create namespace:

kubectl create namespace demo -->


### install chart

<!-- helm install --namespace demo --name zookeeper incubator/zookeeper \
      --set replicaCount=1 \
      --set fullnameOverride=zookeeper -->

<!-- 
bash pkg.sh
git checkout gh-pages
helm repo index ./ --url https://asperitus.github.io/helm/
-->

```helm install --namespace demo --name btcpayd asperitus/btcpayd```



