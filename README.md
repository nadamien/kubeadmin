Basic Shell Script to Make Pod Administration Easier, This Version is Specifically Designed for MicroK8s Enviornment

If you want use it as a generic script you can remove the following "microk8s before each kubectl command"

```i.e.microk8s kubectl get pods -n "$namespace"```

Script Demo
```
bash:~$ ./pod_functions.sh
Enter namespace name (default is 'default'):

=================================================
These are the available namespaces
=================================================
NAME              STATUS   AGE
kube-system       Active   82d
kube-public       Active   82d
kube-node-lease   Active   82d
default           Active   82d
ingress           Active   82d
cloud22           Active   82d

=================================================

Enter Namespace Name :
cloud22

================================
Kubernetes Pod Management Menu
================================
1. List all pods
2. Restart all pods
3. Scale up and down pods[0] stop pods scale up[1,2..] start pod
4. Kill Pod by Scaling Pod to 0
5. Exit
Choose an option [1-5]:
```
