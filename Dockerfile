FROM jenkins
# if we want to install via apt
USER root
run apt-get update && apt-get install -y lsb-release
RUN /bin/sh -c 'echo "deb https://pkg.tox.chat/debian stable $(lsb_release -cs)" | tee /etc/apt/sources.list.d/tox.list'
RUN /hin/sh -c 'wget -qO - https://pkg.tox.chat/debian/pkg.gpg.key | apt-key add -'
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get update && apt-get install -y build-essential make valac gcc-* cmake
# drop back to the regular jenkins user - good practice
USER jenkins
