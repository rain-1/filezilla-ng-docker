FROM archlinux/base

RUN pacman -Sy base-devel --noconfirm

# git clone https://github.com/rain-1/libfilezilla-ng.git
# git clone https://github.com/rain-1/filezilla-ng.git

WORKDIR /app
ADD libfilezilla-ng /app

RUN autoreconf -i
RUN ./configure --prefix=/out
RUN make
RUN make install

RUN rm -rf /app

RUN pacman -Sy gtk2 wxgtk2 --noconfirm
RUN pacman -Sy nettle gnutls --noconfirm
RUN pacman -Sy pugixml --noconfirm
RUN pacman -Sy xdg-utils --noconfirm

WORKDIR /app
ADD filezilla-ng /app
RUN autoreconf -i
ENV PKG_CONFIG_PATH /usr/lib/pkgconfig/:/out/lib/pkgconfig
RUN ./configure --prefix=/out
RUN make
RUN make install

# docker build -t filezilla .
# docker run -t -i filezilla

# $ docker ps | grep filezilla | awk '{ print $1 }'
# 019b4ba41a73
# $ rm -rf out ; docker cp 019b4ba41a73:/out out
