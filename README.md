# SwayonVNC

## Sway window manager is installed on a docker alpine image with foot as a terminal and other applications installed too. Sway is a window manager just like xfce4 and gnome etc. 

### You can pull this image form docker hub or you can build an image from the docker file present in this repository.

Docker pull command: 

``` 
docker pull rajamuneer/sway

```

### If you want to build an image from the docker file in this repository.Then you need to create a folder in your home directory and copy all these files to the directory you just created and run the following command:

```
docker buld -t sway ./

```

This will build an image out of the docker file.

### To run the docker image

Write following commands to run the image

```
docker run -e XDG_RUNTIME_DIR=/tmp \
                    -e WLR_BACKENDS=headless \
                    -e WLR_LIBINPUT_NO_DEVICES=1 \
                    -e SWAYSOCK=/tmp/sway-ipc.sock \
                    -p 5910:5900 \
                     <imagename>

```

## Note: You will need a vnc viewer to view the image output.
Here I am using port 0.0.0.0:5910 on remmina to access the screen.
![image](https://user-images.githubusercontent.com/105891199/197418956-3480b56f-f68b-4907-8593-435887fd816f.png)

I have changed the mod key in sway config file to use alt instead of windows. To open a terminal in swaywm use alt+enter key. 
![image](https://user-images.githubusercontent.com/105891199/197419138-cffa34dc-08b2-4c81-b550-4b28abf5cfce.png)
