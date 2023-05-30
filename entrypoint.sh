#!/bin/bash
cat > /etc/supervisor/supervisord.conf << EOF
[supervisord]
nodaemon=true
logfile=/var/log/supervisord.log
[program:agent]
command=nezha-agent -s ${panel_domain}:${port} -p ${secret}
autostart=true
autorestart=true
EOF

supervisord -c /etc/supervisor/supervisord.conf