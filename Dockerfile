FROM jenkins
# if we want to install via apt
USER root
run apt-get update && apt-get install -y lsb-release apt-transport-https
RUN echo "deb https://pkg.tox.chat/debian stable $(lsb_release -cs)" | tee /etc/apt/sources.list.d/tox.list
RUN echo "deb https://cmotc.github.io/lair-web/lair-deb/debian rolling main" | tee /etc/apt/sources.list.d/cmotc.github.io.lair-web.lair-deb.list
RUN echo "deb-src https://cmotc.github.io/lair-web/lair-deb/debian rolling main" | tee /etc/apt/sources.list.d/cmotc.github.io.lair-web.lair-deb.list
RUN wget -qO - https://pkg.tox.chat/debian/pkg.gpg.key | apt-key add -
RUN wget -qO - https://cmotc.github.io/lair-web/lair-deb/cmotc.github.io.lair-web.lair-deb.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y build-essential make valac gcc-4.9-base cmake libtox-dev libtoxav-dev libtoxcore-dev libtoxdns-dev libtoxencryptsave-dev valgrind liblua5.2-dev clang sdl2-vapi devscripts debhelper dh-make
# drop back to the regular jenkins user - good practice
USER jenkins
