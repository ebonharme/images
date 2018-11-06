#/bin/sh

# Required env vars:
# ECR_REGION     e.g. eu-west-2
# ECR_ROLE_NAME  e.g. rol-deployment-agent
# ECR_ACCOUNT    e.g. 123456678910

# Construct full Arn for the role we want to assume
ROLE_ARN=arn:aws:iam::${ECR_ACCOUNT}:role/${ECR_ROLE_NAME}

# Instance credencials from profile:
INSTANCE_PROFILE=`curl --silent http://169.254.169.254/latest/meta-data/iam/security-credentials`
INSTANCE_CREDS=`curl --silent http://169.254.169.254/latest/meta-data/iam/security-credentials/$INSTANCE_PROFILE`
AWS_ACCESS_KEY_ID=`echo ${INSTANCE_CREDS} | jq '.Credentials.AccessKeyId'`
AWS_SECRET_ACCESS_KEY=`echo ${INSTANCE_CREDS} | jq '.Credentials.AccessKeyId'`
AWS_SESSION_TOKEN=`echo ${INSTANCE_CREDS} | jq '.Credentials.SessionToken'`

CREDS=`aws sts assume-role --role-arn ${ROLE_ARN} --role-session-name ${HOSTNAME}ECRAgent`
SESSION_KEY=`echo ${CREDS} | jq '.Credentials.AccessKeyId'`
SESSION_SECRET=`echo ${CREDS} | jq '.Credentials.SecretAccessKey'`
SESSION_TOKEN=`echo ${CREDS} | jq '.Credentials.SessionToken'`

echo AWS_ACCESS_KEY_ID=${SESSION_KEY} AWS_SECRET_ACCESS_KEY=${SESSION_SECRET} AWS_SESSION_TOKEN=${SESSION_TOKEN} aws ecr get-login --region ${ECR_REGION} --registry-ids ${ECR_ACCOUNT} > ./docker-login
chmod +x ./docker-login

DOCKER_AUTH=`sh -c ./docker-login | cut -d' ' -f6`

# Get the existing config off the volume
cp /etc/ecs/ecs.config /tmp/
# Remove previous ECS_ENGINE_AUTH
sed -i '/ECS_ENGINE_AUTH_TYPE/d' /tmp/ecs.config
sed -i '/ECS_ENGINE_AUTH_DATA/d' /tmp/ecs.config
# Replace with new ones
echo ECS_ENGINE_AUTH_TYPE=dockercfg >> /tmp/ecs.config
echo ECS_ENGINE_AUTH_DATA=dockercfg:{"https://$ECR_ACCOUNT.dkr.ecr.$ECR_REGION.amazonaws.com/v2/":{"auth":"$DOCKER_AUTH","email":"email@example.com"}} >> /tmp/ecs.config
# Stick back in place ensuring there's a backup
cp /etc/ecs/ecs.config /etc/ecs/ecs.config.bak
cat /tmp/ecs.config > /etc/ecs/ecs.config
