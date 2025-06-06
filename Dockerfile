FROM ubuntu:24.04

ENV DOWNLOAD_DIR /data/
ENV HOME /home/mega
ENV WEBSOCKET_PORT 8080
ENV EXTERNAL_HOST localhost
ENV EXTERNAL_PORT 8080
ENV NEW_FILE_PERMISSIONS 600
ENV NEW_FOLDER_PERMISSIONS 700
ENV TRANSFER_LIST_LIMIT 50
ENV PATH_DISPLAY_SIZE 80
ENV INPUT_TIMEOUT 0.0166
ENV FILE_UPDATE_TIMEOUT 0.1

ADD https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1_amd64.deb ./
ADD https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megacmd_2.1.1-1.1_amd64.deb ./

RUN apt-get update; \
    apt-get install ./websocketd*.deb ./megacmd*.deb -y; \
    apt-get clean; \
    rm ./websocketd*.deb ./megacmd*.deb; \
    mkdir --parents ${HOME}; \
    chmod 777 ${HOME}; \
    mkdir --parents ${DOWNLOAD_DIR}; \
    chmod 777 ${DOWNLOAD_DIR};

COPY files/ ${HOME}
EXPOSE ${WEBSOCKET_PORT}

ENTRYPOINT ${HOME}/entrypoint.sh
