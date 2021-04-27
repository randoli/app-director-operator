# Install kind
echo "----------------------------------"
echo "Installing Kind"
echo "----------------------------------"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64
chmod +x ./kind

# Create a cluster using kind
echo "----------------------------------"
echo "Creating Kind cluster and configuring the kubectl context"
echo "----------------------------------"
./kind create cluster --name guvnor-operator --image kindest/node:v1.19.7

# Setup local kind to use the kind 
kubectl config use-context kind-guvnor-operator

#Install images in kind
echo "----------------------------------"
echo "Installing images in kind"
echo "----------------------------------"

docker pull randoli/app-director-operator:dev

docker pull randoli/app-director:dev

docker pull quay.io/buildah/stable:v1.17.0

docker pull quay.io/openshift-pipeline/s2i:nightly

docker pull gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.18.1

./kind load docker-image randoli/app-director-operator:dev --name guvnor-operator

./kind load docker-image randoli/app-director:dev --name guvnor-operator

./kind load docker-image quay.io/buildah/stable:v1.17.0 --name guvnor-operator

./kind load docker-image quay.io/openshift-pipeline/s2i:nightly --name guvnor-operator

./kind load docker-image gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.18.1 --name guvnor-operator


#Create namespace and apply the secrets
echo "----------------------------------"
echo "Creating namespace and applying the secrets"
echo "----------------------------------"
kubectl create namespace app-director

kubectl config set-context --current --namespace=app-director

kubectl apply -f guvnor-secret.yaml

# Download the repository
echo "----------------------------------"
echo "Applying Guvnor operator"
echo "----------------------------------"
kubectl apply -f ../operator.yaml

if [ -z "${CLUSTER_WIDE}" ]
then
    echo "----------------------------------"
    echo "Applying NameSpaced Guvnor"
    echo "----------------------------------"
    kubectl apply -f ../samples/appdirector_v1beta1_guvnor.yaml
      
else
    echo "----------------------------------"
    echo "Applying Cluster Wide Guvnor"
    echo "----------------------------------"
    kubectl apply -f ../samples/appdirector_v1beta1_clusterwideguvnor.yaml     
fi













