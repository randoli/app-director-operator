# App Director Operator

# Installing the Operator
1. Download the required secrets YAML file from the App Director application.
2. Apply the operator YAML: `kubectl apply operator.yaml`.
3. If not already created, create the namespace where Guvnor will be deployed to: `kubectl create namespace <name>`
4. Apply the secrets YAML downloaded from the application: `kubectl apply <secrets>.yaml`
5. For ***Namespace*** Scoped: Modify `appdirector_v1beta1_guvnor.yaml` to the namespace Guvnor will be deployed to and apply it.
6. For ***Cluster*** Scoped: Modify `spec.namespace` for `appdirector_v1beta1_clusterwideguvnor.yaml` to the namespace Guvnor will be deployed to and apply it.
