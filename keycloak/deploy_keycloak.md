helm get values <release-name> -n <namespace> > my-values.yaml


helm upgrade keycloak bitnami/keycloak -n keycloak -f my-values.yaml
