FROM ubuntu:bionic
LABEL maintainer="Roman Mingazeev"
LABEL email="direnol@yandex.ru"

ENV \
    USER=user \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    DIR=/data

RUN \
    adduser --shell /bin/bash --home /home/${USER} \
    --gecos '' --disabled-password ${USER} &&\
    apt update && apt install -y make latexmk texlive-base \
    texlive-formats-extra texlive-latex-recommended texlive-lang-cyrillic \
    texlive-science texlive-xetex

RUN \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections &&\
    apt update && apt install -y texlive-latex-extra sudo\
        texlive-fonts-extra wget git make apt-transport-https unzip && \
    echo "${USER} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${USER}

# Times New Roman and other fonts
RUN wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb &&\
    dpkg -i ttf-mscorefonts-installer_3.6_all.deb || apt install -f -y && rm -f ttf-mscorefonts-installer_3.6_all.deb &&\
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    fc-cache -f -v

USER ${USER}
VOLUME [ "${DIR}" ]
WORKDIR ${DIR}
