#!/bin/env bash

if [ "$1" = "--list" ]; then

export FOLDER_ID=$(yc config list | grep folder-id | awk -F': ' '{print $2}')
export IAM_TOKEN=$(yc iam create-token)

app_ansible_host=$(curl -s -H "Authorization: Bearer ${IAM_TOKEN}" \
https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=${FOLDER_ID} | \
jq -c '.instances[]? | select(.name=="reddit-app") | .networkInterfaces[0] | .primaryV4Address | .oneToOneNat | .address')

db_ansible_host=$(curl -s -H "Authorization: Bearer ${IAM_TOKEN}" \
https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=${FOLDER_ID} | \
jq '.instances[]? | select(.name=="reddit-db") | .networkInterfaces[0] | .primaryV4Address | .oneToOneNat | .address')

cat <<EOF
{
    "app": {
        "hosts": [
            "appserver"
        ]
    },
    "db": {
        "hosts": [
            "dbserver"
        ]
    },
    "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": $app_ansible_host
            },
            "dbserver": {
                "ansible_host": $db_ansible_host
            }
        }
    }
}
EOF
elif [ "$1" == "--host" ]; then
    echo '{"_meta": {hostvars": {}}}'
else
    echo "{ }"
fi
