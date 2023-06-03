#!/bin/bash
cat > /etc/supervisord.conf << EOF
[supervisord]
nodaemon=true
logfile=/var/log/supervisord.log
[program:agent]
command=nezha-agent -s ${panel_domain}:${port} -p ${secret} ${args}
autostart=true
autorestart=true
EOF

supervisord -c /etc/supervisord.conf