FROM jenkins
# if we want to install via apt
USER root
run apt-get update && apt-get install -y apt-transport-https apt-utils
RUN echo "deb https://pkg.tox.chat/debian stable jessie" | tee /etc/apt/sources.list.d/tox.list
RUN echo "deb https://cmotc.github.io/lair-web/lair-deb/debian rolling main" | tee /etc/apt/sources.list.d/cmotc.github.io.lair-web.lair-deb.list
RUN echo "deb-src https://cmotc.github.io/lair-web/lair-deb/debian rolling main" | tee -a /etc/apt/sources.list.d/cmotc.github.io.lair-web.lair-deb.list
RUN echo "deb http://ftp.us.debian.org/debian/ sid main non-free contrib" | tee /etc/apt/sources.list.d/sid.list
RUN echo "deb-src http://ftp.us.debian.org/debian/ sid main non-free contrib" | tee -a /etc/apt/sources.list.d/sid.list
COPY be-stable /etc/apt/preferences.d/
RUN wget -qO - https://pkg.tox.chat/debian/pkg.gpg.key | apt-key add -
RUN wget -qO - https://cmotc.github.io/lair-web/lair-deb/cmotc.github.io.lair-web.lair-deb.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y build-essential make valac* gcc-4.9-base cmake libsdl2-*-dev libvala*-dev valgrind liblua5.2-dev clang devscripts debhelper dh-make golang
RUN apt-get install -y libtox-dev libtoxav-dev libtoxcore-dev libtoxdns-dev libtoxencryptsave-dev
RUN apt-get install -y sdl2-vapi tox-vapi tartrazine
# drop back to the regular jenkins user - good practice
USER jenkins
