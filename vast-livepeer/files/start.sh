# configure remote_syslog2
cp /app/templates/log_files.yml /etc/log_files.yml
sed -e "s|{{HOST}}|$PAPERTRAIL_HOST|" -i /etc/log_files.yml
sed -e "s|{{PORT}}|$PAPERTRAIL_PORT|" -i /etc/log_files.yml

# configure supervisord
cp /app/templates/supervisord.conf /etc/supervisord.conf
sed -e "s|{{ARGS}}|$LIVEPEER_ARGS|" -i /etc/supervisord.conf

# start supervisor
/usr/bin/supervisord
