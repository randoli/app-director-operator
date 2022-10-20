# App Director Operator

# Installing the Operator

1. Apply the operator YAML: `kubectl apply -f operator.yaml`.
2. If not already created, create the namespace where the App Director agent will be deployed to: `kubectl create namespace <name>`
3. Download the required Cluster Agent secret YAML file from the App Director application.
4. Apply the secret YAML downloaded from the application to the namespace where the App Director agent will be deployed to: `kubectl apply -f secret.yaml -n <name>`
5. For ***Namespace*** Scoped: Modify `appdirector_v1beta1_appdirectoragent.yaml` to include the namespace the agent will be deployed as well as the namespaces the agent will manage. Once complete, apply it: `kubectl apply -f appdirector_v1beta1_appdirectoragent.yaml`
6. For ***Cluster*** Scoped: Modify the `spec.namespace` field in `appdirector_v1beta1_clusterwideappdirectoragent.yaml` to the namespace that the agent will be deployed to. once complete, apply it: `kubectl apply -f appdirector_v1beta1_clusterwideappdirectoragent.yaml`