#!/bin/bash

#check domain and secret variables
if [[ -z "${_DOMAIN}" || -z "${_SECRET}" ]]; then  
    echo "Domain and secret cannot be empty!"
    exit 1
fi

#modify platform
if [ -n "${platform}" ] || [ -n "${version}" ]; then
    rm -f /etc/debian_version
    if [ -n "${platform}" ]; then
        sed -i "s/^ID=.*/ID=${platform}/" /etc/os-release
    fi

    if [ -n "${version}" ]; then
        sed -i "s/^VERSION=.*/VERSION=${version}/" /etc/os-release
    fi
fi

exec /usr/local/bin/nezha-agent -s ${_DOMAIN}:${port} -p ${_SECRET} ${args}  
