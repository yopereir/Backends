#!/bin/bash
# prereqs: Install kustomize rm -rf kustomize && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && mv -f kustomize /opt/homebrew/bin/kustomize
while test $# -gt 0; do
  case "$1" in
    -fn|--fresh-namespace)
      echo "Namespace will be deleted and re-created."
      kubectl delete namespace kserve || echo 0
      shift
      ;;
    *)
      break
      ;;
  esac
done

# Create and deploy k8s resources
kubectl create namespace kserve

# Deploy Kubeflow platform
git clone https://github.com/kubeflow/manifests.git
cd manifests
# All at once
# while ! kustomize build example | kubectl apply --server-side --force-conflicts -f -; do echo "Retrying to apply resources"; sleep 20; done

# Individually
## Namespace
kustomize build common/kubeflow-namespace/base | kubectl apply -f -

## Cert-manager
kustomize build common/cert-manager/base | kubectl apply -f -
sleep 15
kustomize build common/cert-manager/kubeflow-issuer/base | kubectl apply -f -
echo "Waiting for cert-manager to be ready ..."
kubectl wait --for=condition=Ready pod -l 'app in (cert-manager,webhook)' --timeout=180s -n cert-manager
kubectl wait --for=jsonpath='{.subsets[0].addresses[0].targetRef.kind}'=Pod endpoints -l 'app in (cert-manager,webhook)' --timeout=180s -n cert-manager

## Istio CNI
echo "Installing Istio CNI configured with external authorization..."
kustomize build common/istio/istio-crds/base | kubectl apply -f -
kustomize build common/istio/istio-namespace/base | kubectl apply -f -
# For most platforms (Kind, Minikube, AKS, EKS, etc.)
kustomize build common/istio/istio-install/overlays/oauth2-proxy | kubectl apply -f -
# For Google Kubernetes Engine (GKE), use:
# kustomize build common/istio/istio-install/overlays/gke | kubectl apply -f -
echo "Waiting for all Istio Pods to become ready..."
kubectl wait --for=condition=Ready pods --all -n istio-system --timeout 300s

## OAuth2-proxy
echo "Installing oauth2-proxy..."
kustomize build common/oauth2-proxy/overlays/m2m-dex-only/ | kubectl apply -f -
kubectl wait --for=condition=Ready pod -l 'app.kubernetes.io/name=oauth2-proxy' --timeout=180s -n oauth2-proxy

# KServe
kustomize build applications/kserve/kserve | kubectl apply --server-side --force-conflicts -f -
kustomize build applications/kserve/models-web-app/overlays/kubeflow | kubectl apply -f -

# Katib
kustomize build applications/katib/upstream/installs/katib-with-kubeflow | kubectl apply -f -

# Dashboard
kustomize build applications/centraldashboard/overlays/oauth2-proxy | kubectl apply -f -

# Admission Webhook
kustomize build applications/admission-webhook/upstream/overlays/cert-manager | kubectl apply -f -

# Notebooks
kustomize build applications/jupyter/notebook-controller/upstream/overlays/kubeflow | kubectl apply -f -
kustomize build applications/jupyter/jupyter-web-app/upstream/overlays/istio | kubectl apply -f -

# Notebooks 2.0 with PVC
kustomize build applications/pvcviewer-controller/upstream/base | kubectl apply -f -

# Profiles + KFAM
kustomize build applications/profiles/upstream/overlays/kubeflow | kubectl apply -f -

# Volumes webapp
kustomize build applications/volumes-web-app/upstream/overlays/istio | kubectl apply -f -

# Tensorboard
kustomize build applications/tensorboard/tensorboards-web-app/upstream/overlays/istio | kubectl apply -f -
kustomize build applications/tensorboard/tensorboard-controller/upstream/overlays/kubeflow | kubectl apply -f -

# Trainer
kustomize build applications/trainer/upstream/overlays/kubeflow-platform | kubectl apply --server-side --force-conflicts -f -
# kustomize build applications/training-operator/upstream/overlays/kubeflow | kubectl apply --server-side --force-conflicts -f -

# Spark Operator
kustomize build applications/spark/spark-operator/overlays/kubeflow | kubectl apply -f -

# User Namespace
kustomize build common/user-namespace/base | kubectl apply -f -


# Port forward
kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80 # default creds: user@example.com, 12341234