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

USER ${USER}
VOLUME [ "${DIR}" ]
WORKDIR ${DIR}
