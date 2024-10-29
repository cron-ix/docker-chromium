# Start with base image
FROM dtcooper/raspberrypi-os:bookworm

# Set up hostname and install chromium-browser
RUN echo "chromiumbox" > /etc/hostname && apt-get update && apt-get install --no-install-recommends chromium-browser libwidevinecdm0 -y

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

# Copy Pulseaudio config
COPY pulse-client.conf /etc/pulse/client.conf

# Start chromium-browser
CMD ["/usr/bin/chromium-browser"]
