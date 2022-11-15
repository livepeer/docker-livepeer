FROM ubuntu:22.04

RUN	apt update \
  && apt install -yqq curl ffmpeg \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L https://lvpr.link/bbb-mp4 -o /BigBuckBunny.mp4

ENTRYPOINT ["/usr/bin/ffmpeg"]
