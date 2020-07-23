FROM ubuntu:20.04
LABEL maintainer="hello@erickueen.dev"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y curl git
RUN apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN cd ~/.asdf && git checkout "$(git describe --abbrev=0 --tags)"
ENV PATH /root/.asdf/bin:/root/.asdf/shims:${PATH}
RUN /bin/bash -c "source ~/.bashrc"
RUN /bin/bash -c "asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git"
ENV KERL_CONFIGURE_OPTIONS --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --disable-debug --without-javac --enable-darwin-64bit
RUN /bin/bash -c "asdf install erlang 23.0.3"
RUN apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN /bin/bash -c "asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git"
RUN /bin/bash -c "asdf global erlang 23.0.3"
RUN /bin/bash -c "asdf install elixir ref:1145dc01680aab7094f8a6dbd38b65185e14adb4"
RUN /bin/bash -c "asdf global elixir ref:1145dc01680aab7094f8a6dbd38b65185e14adb4"
RUN /bin/bash -c "asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git"
RUN /bin/bash -c "bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'"
RUN /bin/bash -c "asdf install nodejs 12.18.3"
RUN /bin/bash -c "asdf global nodejs 12.18.3"
RUN apt-get install -y inotify-tools
RUN /bin/bash -c "mix local.hex --force"
RUN /bin/bash -c "mix local.rebar --force"
RUN /bin/bash -c "mix archive.install --force hex phx_new 1.5.4"
