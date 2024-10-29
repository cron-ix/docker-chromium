# Start with base image
FROM dtcooper/raspberrypi-os:bookworm

# Install chromium-browser
RUN apt-get update && apt-get install -y chromium-browser

# Set up hostname and the user
ENV UNAME chromiumuser
RUN echo "chromiumbox" > /etc/hostname && \
    export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio
USER $UNAME
ENV HOME /home/${UNAME}

# Copy Pulseaudio config
COPY pulse-client.conf /etc/pulse/client.conf

# Start chromium-browser
CMD ["/usr/bin/chromium-browser"]
