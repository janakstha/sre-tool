# Delete Pods stuck in Terminating status
# https://stackoverflow.com/questions/35453792/pods-stuck-in-terminating-status

#!/bin/bash
#set -x
kubectl get pods --all-namespaces | grep Terminating | while read line; do
  pod_name=$(echo $line | awk '{print $2}' ) \
  name_space=$(echo $line | awk '{print $1}' ); \
  kubectl patch pod $pod_name -n $name_space -p '{"metadata":{"finalizers":null}}' ;\
  kubectl delete pods $pod_name -n $name_space --grace-period=0 --force
done

#set +x