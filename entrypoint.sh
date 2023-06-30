#!/bin/bash
#supervisor config
cat > /etc/supervisord.conf << EOF
[supervisord]
nodaemon=true
logfile=/var/log/supervisord.log
[program:agent]
command=nezha-agent -s ${domain}:${port} -p ${secret} ${args}
autostart=true
autorestart=true
EOF

#modify platform
if [ -n "${platform}" ] && [ -n "${version}" ]; then
    sed -i "s/^ID=.*/ID=${platform}/" /etc/os-release
    sed -i "s/^VERSION_ID=.*/VERSION=${version}/" /etc/os-release
else
    platform=$(uname -v)
    version=$(uname -r)
    if echo "$platform" | grep -qi "debian"; then
        platform="debian"
    elif echo "$platform" | grep -qi "ubuntu"; then
        platform="ubuntu"
    else
        platform="Linux"
    fi
    version=${version%%-*}
    sed -i "s/^ID=.*/ID=${platform}/" /etc/os-release
    sed -i "s/^VERSION_ID=.*/VERSION=${version}/" /etc/os-release
fi


#start supervisor
supervisord -c /etc/supervisord.conf