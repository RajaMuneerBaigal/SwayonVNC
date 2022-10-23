FROM alpine:latest

RUN apk update  
RUN apk add build-base \
nano \
sudo \ 
ttf-dejavu \
sway \
 sway-doc \ 
 xwayland \ 
 foot \
 bemenu \
 swaylock \
 swaylockd \ 
 swaybg \
 swayidle \ 
 rofi \
 waybar \
 xkeyboard-config \
 wayvnc

ENV alpine="x86_64" \
    USER="Rohan" \
    VNC_LISTEN_ADDRESS="0.0.0.0" \
    VNC_AUTH_ENABLE="false" \
    VNC_PASS="1234" \
    XDG_RUNTIME_DIR="\tmp" \
    WLR_BACKENDS="headless" \
    WLR_LIBINPUT_NO_DEVICES="1" 
RUN apk add -X https://dl-cdn.alpinelinux.org/alpine/v3.16/main -u alpine-keys --allow-untrusted
RUN adduser -D $USER && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
RUN echo "Rohan:rohan" | chpasswd



RUN mkdir /etc/sway/config.d \
    && echo "exec wayvnc 0.0.0.0 5900" >> /etc/sway/config.d/exec \
    && echo "exec \"socat TCP-LISTEN:7023,fork UNIX-CONNECT:/tmp/sway-ipc.sock\"" >> /etc/sway/config.d/exec \
    && mkdir -p /home/$USER/.config/wayvnc/ \
    && printf "\
address=$VNC_LISTEN_ADDRESS\n\
enable_auth=$VNC_AUTH_ENABLE\n\
username=$USER\n\
password=$VNC_PASS\n" > /home/$USER/.config/wayvnc/config
RUN apk add git
RUN git clone https://github.com/novnc/noVNC.git
WORKDIR noVNC
COPY config /etc/sway/config
EXPOSE 5900
# Add entrypoint
USER $USER

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
