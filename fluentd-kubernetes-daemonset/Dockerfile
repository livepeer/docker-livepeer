# This is needed to handle Docker (JSON) and containerd (flat file) logs with the same config. Which is nice.
FROM fluent/fluentd-kubernetes-daemonset:v1-debian-papertrail
RUN fluent-gem install fluent-plugin-multi-format-parser
