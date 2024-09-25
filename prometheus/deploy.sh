export NAMESPACE="prometheus"

# Set dns resolution
if $(cat /etc/hosts | grep -q prometheus.test);then
 sudo sed -i -e "s/.*prometheus.test.*/$(echo "127.0.0.1 prometheus.test")/" /etc/hosts;
 else 
 echo "127.0.0.1 prometheus.test" | sudo tee -a /etc/hosts;
fi

kubectl delete namespace $NAMESPACE || echo 0
kubectl create namespace $NAMESPACE
kubectl apply -f . --namespace $NAMESPACE