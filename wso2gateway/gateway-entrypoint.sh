#!/bin/bash

echo "Waiting for control plane at stack-apim-1:9443..."

until nc -z stack-apim-1 9443; do
  echo "Control plane not up yet. Sleeping 5s..."
  sleep 5
done

echo "Control plane is up. Running profile setup..."

sh /home/wso2carbon/wso2am-3.2.0/bin/profileSetup.sh -Dprofile=gateway-worker

echo "Starting gateway..."

exec /home/wso2carbon/wso2am-3.2.0/bin/wso2server.sh
