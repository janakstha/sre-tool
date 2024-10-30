#!/bin/bash
# set -x
# Step 1: Get all ALBs
ALBS=$(aws elbv2 describe-load-balancers --query 'LoadBalancers[*].{Name:LoadBalancerName,ARN:LoadBalancerArn}' --output json)

# Step 2: Iterate over each ALB
echo "$ALBS" | jq -c '.[]' | while read -r alb; do
  LB_NAME=$(echo "$alb" | jq -r '.Name')
  LB_ARN=$(echo "$alb" | jq -r '.ARN')
  echo "Load Balancer: $LB_NAME"

  # Step 3: Get all listeners for this ALB
  LISTENERS=$(aws elbv2 describe-listeners --load-balancer-arn "$LB_ARN" --query 'Listeners[*].{Port:Port,ARN:ListenerArn}' --output json)

  # Step 4: Iterate over each listener
  echo "$LISTENERS" | jq -c '.[]' | while read -r listener; do
    LISTENER_PORT=$(echo "$listener" | jq -r '.Port')
    LISTENER_ARN=$(echo "$listener" | jq -r '.ARN')

    # Step 5: Get the SSL policy for this listener
    SSL_POLICY=$(aws elbv2 describe-listeners --listener-arn "$LISTENER_ARN" --query 'Listeners[*].SslPolicy' --output text)

    echo "  Port: $LISTENER_PORT"
    echo "  SSL Policy: $SSL_POLICY"
  done
done

#set +x
