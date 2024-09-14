#!/bin/sh
###########################################################################
#                                                                         #
# Purpose: Kubernets Pod Functionality Using Menu Driven Bash Script      #
# Created By : Pasindu W                                                  #
# Version 1.0                                                             #
###########################################################################

list_pods() {
    echo "================================================="
    echo "Listing all pods in namespace $namespace..."
    echo "================================================="
    echo " "
    microk8s kubectl get pods -n "$namespace"
    echo "  "
}


list_deployments() {
    echo "================================================="
    echo "Listing all deployments in namespace $namespace..."
    echo "================================================="
    echo " "
    microk8s kubectl get deployment -n "$namespace"
    echo "  "
    echo "  "
    list_pods
}

stop_single_dep(){
  list_deployments
  echo "==================================================================="
  echo "Enter Deployment Name to Kill The Pod/Stop Deployment"
  read dep_in
  microk8s kubectl scale deployment "$dep_in" --replicas=0 -n "$namespace"
  list_deployments
}

list_ns() {
    microk8s kubectl get namespace
     echo "  "
}

restart_pods() {
    local namespace=$1
    echo "================================================="
    echo "Restarting all pods in namespace $namespace..."
    echo "================================================="
    echo " "
    microk8s kubectl delete pod --all -n "$namespace"
    echo " "
}

scale_up_deployments() {
    local namespace=$1
    echo "================================================="
    echo "Enter Value to Scale Up(+) and Down(-)"
    read scale
    echo " "
    echo "======================================================================="
    echo "Scaling up all deployments to $scale replica in namespace $namespace..."
    echo "======================================================================="
    deployments=$(microk8s kubectl get deployments -n "$namespace" -o jsonpath='{.items[*].metadata.name}')
    for deployment in $deployments; do
        microk8s kubectl scale deployment "$deployment" --replicas=$scale -n "$namespace"
    done
    echo " "
}

main_menu() {
    echo "Enter namespace name (default is 'default'): "
    echo " "
    echo "================================================="
    echo "These are the available namespaces "
    echo "================================================="
    list_ns
    echo "================================================="
    echo " "
    echo "Enter Namespace Name : "
    read namespace

    namespace=${namespace:-default}

    while true; do
        echo "  "
        echo "================================"
        echo "Kubernetes Pod Management Menu"
        echo "================================"
        echo "1. List all pods"
        echo "2. Restart all pods"
        echo "3. Scale up and down pods[0] stop pods scale up[1,2..] start pods"
        echo "4. Kill Single Pod by Scaling Pod to 0"
        echo "5. Exit"
        echo -n "Choose an option [1-5]: "
        read option

        case $option in
            1)
                clear
                list_pods "$namespace"
                ;;
            2)
                clear
                                restart_pods "$namespace"
                ;;
            3)
                clear
                scale_up_deployments "$namespace"
                ;;
            4)
               clear
               stop_single_dep
                ;;
            5)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid option. Please choose between 1 and 4."
                ;;
        esac
    done
}
main_menu                                                               