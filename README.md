# POCSAG-Local-Time
Force Pi-Star DAPNET/POCSAG to send LOCAL time on RIC 224 to auto set time on pager

So, I had purchased an Alphapoc style pager (the typical Chinese clone on ebay Model GP2009N)
and it works great.... But one thing I noted, supposedly if you add RIC 224 in slot 8 it will automatically set the pager's clock to local time.

Well, turns out that's not QUITE accurate.... It will set it to the local time of whatever DAPNET host you're connecting to... so in my case, it was setting my pager to the time in Germany.... I could use RIC 216 and have it use UTC.... But I REALLY wanted it to set to LOCAL time of my Pi-Star hotspot.... so, here's the solution I came up with.

First... I blacklisted 224 in the POCSAG config in Pi-Star
Then I placed the POCSAGLocalTime python program in /usr/local/bin and chmod it to 755 chown mmdvm:mmdvm

What this program does is, it checks our DAPNETGateway log file, and checks what timeslots we've been assigned.  This is important because if a DAPNET transmitter is transmitting outside of its assigned timeslot, there is a risk of it interferring with another DAPNET transmitter, so its critical to the DAPNET network that the timeslots are respected... For that reason, if you're running a DAPNET transmitter you must synchronize to an NTP time source.  

So, once we know our timeslot, it calculates when the next assigned timeslot is, and then using the RemoteCommand functionality of pi-star, it sends a page locally as RIC 224 (doesn't go over DAPNET) in our correct timeslot... it then sleeps for 4 minutes, and does it all over again... sending out correct local time to RIC 224 every 4 minutes, simulating the real RIC 224 from DAPNET that we blacklisted because it was giving Germany time.

So, what I've effectively done is blocked the DAPNET RIC224 Germany local time message, and replaced it with my own using my Pi-Star's ACTUAL local time... 
now my pager gets its TRUE local time

If using the systemd.service file I've included, it won't start the application until the system time has been synchronized, so make sure you enable the systemd-time-wait-sync.service with 'sudo systemctl enable systemd-time-wait-sync.service'
