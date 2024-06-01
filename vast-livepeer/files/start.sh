# configure remote_syslog2
cp /app/templates/log_files.yml /etc/log_files.yml
sed -e "s|{{HOST}}|$PAPERTRAIL_HOST|" -i /etc/log_files.yml
sed -e "s|{{PORT}}|$PAPERTRAIL_PORT|" -i /etc/log_files.yml

# configure supervisord
ORCH_ADDR=$(curl -s $GEO_RESOLVER | jq --raw-output .[0].orchestrator)

cp /app/templates/supervisord.conf /etc/supervisor/conf.d/livepeer.conf
sed -e "s|{{ARGS}}|$LIVEPEER_ARGS|" -i /etc/supervisor/conf.d/livepeer.conf
# NOTE: replace this after {{LIVEPEER_ARGS}} so it can be used in livepeer args
sed -e "s|{{ORCH_ADDR}}|$ORCH_ADDR|" -i /etc/supervisor/conf.d/livepeer.conf

# start supervisor
/usr/bin/supervisord
