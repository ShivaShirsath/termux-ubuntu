![](banner-o.png)
![]()
![](distro/gui.png)

<p align="center"><b>Run Ubuntu GUI on your termux with much features.</b></p>

### Features

- Fixed Audio Output
- Lightweight { Requires at least 4GB Storage }
- WhiteSur macOS [theme](https://github.com/ShivaShirsath/MacOS-theme-for-Ubuntu.git) ( [GTK](https://github.com/vinceliuice/WhiteSur-gtk-theme.git) + [ICON](https://github.com/vinceliuice/WhiteSur-icon-theme.git) + [CURSORS](https://github.com/vinceliuice/WhiteSur-cursors.git) )
- 2 Browsers ( Chromium & Firefox )
- Supports Indian Fonts & Emoji Support
- Java installed ( open JDK 8 ) { [installation](https://github.com/ShivaShirsath/Install-JDK-in-Ubuntu.git) }
- Visual Studio Code 
- Easy for Beginners

### Installation

- First Clone the Repository & Run the setup File

  ```bash
  pkg update -y && pkg upgrade -y
  pkg install git -y
  PWDx=$PWD
  cd ~
  git clone git://github.com/ShivaShirsath/termux-ubuntu.git
  cd termux-ubuntu
  chmod +x setup
  bash setup
  cd $PWDx
  ```

- Then Restart your Termux & Type the following commands

  ```bash
  ubuntu
  ```
  ```bash
  bash cli
  ```

- Type your ubuntu root username. Must be lowercase & no space included.

- Then Again Restart your Termux & Type the following commands

  ```bash
  ubuntu
  ```
  ```bash
  bash gui
  ```

- [ Install VNC VIEWER Apk on your Device. ](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android&hl=en)

- **You have to note your VNC password !!**

- Ubuntu image is now successfully installed .

  - Type [vnc](https://github.com/ShivaShirsath/VNC.git) to Start or Stop VNC server
    ```sql
    vnc
    # Touch on <Start> OR <Stop> to interact to Server
    ```

- Open VNC VIEWER & Click on ╋ Button & Enter the Address `localhost:5901` & Name anything you like
  
  **OR**
  ```bash
  $PREFIX/bin/termux-open vnc://localhost:5901
  ```
- Set the Picture Quality to High for better Quality
- Click on Connect & Input the Password 
- Enjoy :D

### NOTE :

- **Type `ubuntu` to run Ubuntu CLI.**
- **Type `vnc` to Start OR Stop VNC server as a Ubuntu GUI**
- **Touch on `<Start>` OR `<Stop>` Option**

- **Type `bash remove` to remove this Ubuntu OS**

### Install neofetch `sudo apt install neofetch` for Checking Version : 

![](distro/cli-o.png)

### Credits 

   
   > This Tool Uses the ubuntu image provided by the termux package `proot-distro`    
   > Full Credit of the Ubuntu image goes to them    
   > Termux Proot Distro - https://github.com/termux/proot-distro   
   

### If you like our work then dont forget to give a Star :)

