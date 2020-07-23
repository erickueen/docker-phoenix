FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y curl git
RUN apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN cd ~/.asdf && git checkout "$(git describe --abbrev=0 --tags)"
ENV PATH /root/.asdf/bin:&root/.asdf/shims:${PATH}
RUN /bin/bash -c "source ~/.bashrc"
RUN /bin/bash -c "asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git"
ENV KERL_CONFIGURE_OPTIONS --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --disable-debug --without-javac --enable-darwin-64bit
RUN /bin/bash -c "asdf install erlang 23.0.3"
RUN /bin/bash -c "echo $KERL_CONFIGURE_OPTIONS"
RUN /bin/bash -c "erlc"
RUN /bin/bash -c "asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git"
RUN /bin/bash -c "asdf global erlang 23.0.3"
RUN /bin/bash -c "asdf install elixir ref:1145dc01680aab7094f8a6dbd38b65185e14adb4"
RUN /bin/bash -c "asdf global elixir ref:1145dc01680aab7094f8a6dbd38b65185e14adb4"
RUN /bin/bash -c "asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git"
RUN /bin/bash -c "bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'"
RUN /bin/bash -c "asdf install nodejs 12.18.3"
RUN /bin/bash -c "asdf global nodejs 12.18.3"
