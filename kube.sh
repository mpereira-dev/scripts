#!/bin/bash
# Getting Started: https://birthday.play-with-docker.com/kubernetes-docker-desktop/
# Generic Kubernetes

alias kubectl-context="kubectl config current-context"
# Thie enables accessing services via localhost & http.
alias kubectl-proxy="kubectl proxy"

# Get the pod name matching the given expression.
function kubectl-pod {
  local POD_NAME=$1
  echo $(kubectl get pods | grep $POD_NAME | cut -d' ' -f1)
}

# Get the service name matching the given expression.
function kubectl-service {
  local SERVICE_NAME=$1
  echo $(kubectl get services | grep $SERVICE_NAME | cut -d' ' -f1)
}

# Get the containerPort for the given pod.
function kubectl-pod-port {
  local POD_NAME=$1
  kubectl get pod $(kubectl-pod $POD_NAME) --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}'
}

# Forward a local port to a port on the service.
# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/
function kubectl-port-forward {
  local SERVICE_NAME=$1
  local PORT_NUMBER=$2
  kubectl port-forward service/$SERVICE_NAME $PORT_NUMBER:$PORT_NUMBER
}

# Open a terminal into the pod that matches the given expression (1 match expected).
function kubectl-ssh {
  local POD_NAME=$1
  kubectl exec --stdin --tty $(kubectl-pod $POD_NAME) -- /bin/sh
}

# Get a bearer token for the Kubernetes dashboard
function kubectl-bearer {
  printf "\n"
  kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
  printf "\n\n"
}