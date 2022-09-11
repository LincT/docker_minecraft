FROM ubuntu:20.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools openjdk-17-jre vim wget
ADD rootfs /
RUN /download-and-install-minecraft.sh
WORKDIR /minecraft
CMD ["/start.sh"]
