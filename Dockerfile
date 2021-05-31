FROM ubuntu:xenial

RUN apt-get update && \
	apt-get install -y vim git build-essential lsb sudo && \
	apt-get clean

RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
ADD build.tar.gz /opt/
RUN echo "N" | /opt/build/install-build-deps.sh && apt-get clean

RUN useradd builder -u 1000 -s /bin/bash -d /home/builder && \
	mkdir -p /home/builder && \
	cp /root/.bashrc /home/builder && \
	cp /root/.profile /home/builder && \
	chown -R builder:builder /home/builder

RUN cd /opt && \
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
	chown -R builder:builder /opt/depot_tools

ADD patches /opt/patches
ADD args.gn /opt/
ADD do_build.sh /

