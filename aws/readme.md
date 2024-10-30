# Retrieving Amazon EKS optimized Amazon Linux AMI IDs
## https://docs.aws.amazon.com/eks/latest/userguide/retrieve-ami-id.html
aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.28/amazon-linux-2/recommended/image_id \
--region eu-central-1 --query "Parameter.Value" --output text

aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.28/amazon-linux-2023/x86_64/standard/recommended/image_id \
--region eu-central-1 --query "Parameter.Value" --output text