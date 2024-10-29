# Chromium with Widevine in Manjaro/Arch linux

Manjaro/Arch aarch64 (Raspberry Pi 64bit) has no widevine support. So I created an image from "Raspberry Pi OS" (Debian bookworm) base image, which has built-in chromium with widevine support.

Base image:
- [Docker Hub: dtcooper/raspberrypi-os:bookworm](https://hub.docker.com/r/dtcooper/raspberrypi-os)
- [Github: Raspberry Pi OS Docker Base Images](https://github.com/dtcooper/raspberrypi-os-docker)

## Installation

### Install Docker
1. install at host: docker docker-buildx xorg-xhost xxd-standalone: `sudo pamac install docker docker-buildx xxd-standalone`
1. Enable Docker service: `sudo systemctl enable --now docker.service`
1. Add Docker group: `sudo groupadd docker`
1. Add user to group: `sudo usermod -aG docker $USER`
l. Log off and back in

### Build image

1. Clone repo: `git clone https://github.com/cron-ix/docker-chromium.git`
1. Change into directory: `cd docker-chromium`
1. Build image: `./docker-build`

### Run Image

1. Run image using script: `./docker-chromium` or install executable script: `sudo install -m 755 ./docker-chromium /usr/local/bin`
1. Have fun

## ToDo

- Minimze builded image: Check - optimized Dockerfile to reduce filesize from 1.75 GB to 1.16 GB
- Error warning "[53:53:1029/190930.090475:ERROR:gbm_wrapper.cc(79)] Failed to get fd for plane.: No such file or directory (2)
[53:53:1029/190930.090656:ERROR:gbm_wrapper.cc(262)] Failed to export buffer to dma_buf: No such file or directory (2)" => Chromium starts, so warning can be ignored

