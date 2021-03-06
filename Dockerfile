FROM jenkins
# if we want to install via apt
USER root
run apt-get update && apt-get install -y apt-transport-https apt-utils

# Add custom repositories and keys

RUN echo "deb https://pkg.tox.chat/debian stable jessie" | tee /etc/apt/sources.list.d/tox.list
RUN echo "deb https://cmotc.github.io/lair-web/lair-deb/debian rolling main" | tee /etc/apt/sources.list.d/cmotc.github.io.lair-web.lair-deb.list
RUN echo "deb-src https://cmotc.github.io/lair-web/lair-deb/debian rolling main" | tee -a /etc/apt/sources.list.d/cmotc.github.io.lair-web.lair-deb.list
RUN echo "deb http://deb.debian.org/debian sid main" | tee /etc/apt/sources.list.d/sid.list
RUN echo "deb-src http://deb.debian.org/debian sid main" | tee -a /etc/apt/sources.list.d/sid.list
COPY be-stable /etc/apt/preferences.d/
RUN wget -qO - https://pkg.tox.chat/debian/pkg.gpg.key | apt-key add -
RUN wget -qO - https://cmotc.github.io/lair-web/lair-deb/cmotc.github.io.lair-web.lair-deb.gpg.key | apt-key add -
RUN apt-get update
RUN apt-get upgrade -y

# Install basic build dependencies

RUN apt-get install -y -t sid build-essential make valac valac-0.34-vapi \
        libvala-0.34-dev gcc-5-base gcc-5-plugin-dev gcc-5-cross-base \
        cmake valgrind clang devscripts debhelper dh-make golang pkg-config

# Install SDL2 development libraries

RUN apt-get install -y -t sid libsdl2-dev libsdl2-gfx-dev libsdl2-image-dev \
        libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev

# Install Lua development libraries

RUN apt-get install -y -t sid liblua5.2-dev lua5.2-dev libluabind-dev \
        libluabind-examples libluabind-dbg lua-check

# Install Tox development libraries

RUN apt-get install -y libtox-dev libtoxav-dev libtoxcore-dev libtoxdns-dev libtoxencryptsave-dev

# Install custom Vala bindings

RUN apt-get install -y sdl2-vapi tox-vapi tartrazine

# Fix library paths for Lua

RUN ln -s /usr/include/lua5.2/lua.h /usr/include/lua.h
RUN ln -s /usr/include/lua5.2/luaconf.h /usr/include/luaconf.h
RUN ln -s /usr/include/lua5.2/lauxlib.h /usr/include/lauxlib.h
RUN ln -s /usr/include/lua5.2/lua-bitop.h /usr/include/lua-bitop.h
RUN ln -s /usr/include/lua5.2/lualib.h /usr/include/lualib.h
RUN ln -s /usr/include/lua5.2/lua-rrd.h /usr/include/lua-rrd.h

# Install distributed compilation tool and test package tool

RUN apt-get install -y checkinstall distcc

# Install u-boot build dependencies

RUN apt-get install git debootstrap u-boot-tools device-tree-compiler

# Install Linux kernel build dependencies

# drop back to the regular jenkins user - good practice
USER jenkins
