FROM ubuntu as remote_syslog

WORKDIR /root
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/papertrail/remote_syslog2/releases/download/v0.20/remote_syslog_linux_amd64.tar.gz
RUN tar xzf ./remote_syslog*.tar.gz


FROM livepeer/go-livepeer:0.5.10-819784ad-linux

# install remote syslog
COPY --from=remote_syslog /root/remote_syslog/remote_syslog /usr/local/bin

# install packages
RUN apt-get update \
  && apt-get install -y \
    supervisor \
    libnvidia-encode-450 \
    libnvidia-decode-450 \
    curl \
    jq \
    vim \
  && rm -rf /var/lib/apt/lists/*

# Add our support files and scripts
ADD ./files /app
RUN ln -s /app/start.sh /usr/local/bin/start

# Vast will override this image's CMD. Setting the default CMD to bash more
# closely resembles how this will be used in practice. The container will start
# and vast will inject some code to call the cli supplied start command.
CMD ["bash"]

# vast does not like images that use an entrypoint, unset it
ENTRYPOINT []
