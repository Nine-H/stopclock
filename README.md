#StopClock
The only clock app that's right twice a day! coded for elementary OS!

###about
Stopclock is one of those tools that just should have been built in, but I'm glad it wasn't because I plan to make hot $$$ flogging it in appcenter. 

###features

####stopwatch
* starting
* stopping
* lap function

####countdown timer
* countdown from anywhere up to 100:60:60.00
* as many concurrent timers as you want
* sweet management interface

####alarmclock
* dummy

####reminder
* set and delete as many custom recurring alarms as you want.

####world clock
* dummy

###get it
Clone the repository and navigate to it with your terminal of choice

```
mkdir build && cd build
cmake --DCMAKE_INSTALL_PREFIX=/usr ../
make
sudo make install
```

if you see missing icons fix them with

```
sudo update-icon-caches /usr/share/icons/*

```

###you made it this far :D
Amateur apps cop alot of stick for only really scratching the developer's itch, I can't think of an app this describes more thoroughly than this one. So far StopClock has doubled my plank time, improved my posture, and taught me github and vala.

Started on luna, symbolic stopwatch icon from sysprof from the gnome team, first program for linux, really bad but a learning experience, please help out if you can.

Ideally I'd like to solve all these problems before the absolute heat death at the end of the universe (which is 2038 according to my iPod)

http://infiniteundo.com/post/25326999628/falsehoods-programmers-believe-about-time
http://infiniteundo.com/post/25509354022/more-falsehoods-programmers-believe-about-time
