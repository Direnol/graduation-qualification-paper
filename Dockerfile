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
    apt update && apt install -y texlive-latex-extra \
        texlive-fonts-extra wget git make apt-transport-https unzip && \
    echo "${USER} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${USER}

# Times New Roman and other fonts
RUN apt install -y --reinstall ttf-mscorefonts-installer && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget http://www.paratype.ru/uni/public/PTSansOFL.zip && \
    wget http://www.paratype.ru/uni/public/PTMono.zip && \
    unzip PTSansOFL.zip -d /usr/share/fonts/ && unzip PTMono.zip -d /usr/share/fonts/ && \
    rm -f PTSansOFL.zip PTMono.zip && \
    fc-cache -f -v

USER ${USER}
VOLUME [ "${DIR}" ]
WORKDIR ${DIR}
