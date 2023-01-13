# What?
Turn any X application quickly into a VNC server.

This is like xvfb-run, but lets people actually view the framebuffer by connecting via VNC.


# Why?
Convenience. And separation of concerns.
Good for headless regression testing, but where one still wants to debug interactively.

(Also, Saleae Logic GUI 2 needs a proper headless mode)


# How?
We use xvfb-run to start a script.
xvfb-run will export the new $DISPLAY variable.

The script starts x11vnc, then the payload command.
x11vnc will default to expose the current $DISPLAY.

When payload command exits, x11vnc is killed and script exits.
When script exists, xvfb-run exits.

Payload command's exit code is propagated all the way.


# "Installation"
* Install dependencies: xvfb, xvfb-run and x11vnc
* Git clone this repo to somewhere locally
* Add to PATH: `export PATH=$PATH:<where you cloned to locally>`


# Overrideable variables
 * `X11VNC_PASSWD`: Password of VNC server. Default is `whatever`.
 * `XVFB_SERVER_ARGS`: Args for Xvfb. Default is `-screen 0 1024x768x24`.


# Usage Example 1

Step 1: First start something up (here `xterm`) and expose it as a VNC server:
```
$ ./expose-as-vnc-server xterm
The VNC desktop is:      kbnuxcsfw-mped:0
PORT=5900
```

NOTE: `xvfb-run` has a default sleep of 3 seconds before executing the payload command!

Step 2: Connect to the new VNC server, from any machine:
```
vncviewer kbnuxcsfw-mped
```

The default password is 'whatever'.

# Usage Example 2
`X11VNC_PASSWD=p4ssw0rd ./expose-as-vnc-server xterm`

# Usage Example 3
`XVFB_SERVER_ARGS="-screen 0 1920x1080x24" ./expose-as-vnc-server xterm`


# Warning!
* Not mature. Env var overrides may change name.
* Password visible by ps(1). You have been warned!
