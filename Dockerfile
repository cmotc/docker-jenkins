FROM jenkins
# if we want to install via apt
USER root
RUN echo "deb https://pkg.tox.chat/debian stable $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/tox.list
RUN wget -qO - https://pkg.tox.chat/debian/pkg.gpg.key | sudo apt-key add -
RUN sudo apt-get install apt-transport-https
RUN sudo apt-get update
RUN apt-get update && apt-get install -y build-essential make valac gcc-* cmake
# drop back to the regular jenkins user - good practice
USER jenkins
