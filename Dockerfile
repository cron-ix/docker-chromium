# Start with base image
FROM dtcooper/raspberrypi-os:bookworm

# Set up hostname
RUN echo "chromiumbox" > /etc/hostname

# Install chromium-browser
RUN apt-get update && apt-get install -y chromium-browser && apt-get install -y xxd

# Copy Pulseaudio config
COPY pulse-client.conf /etc/pulse/client.conf

# Set up the user
ENV UNAME chromiumuser
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
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

# Start chromium-browser
CMD ["/usr/bin/chromium-browser"]
