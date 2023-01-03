# POCSAG-Local-Time
Force Pi-Star DAPNET/POCSAG to send LOCAL time on RIC 224 to auto set time on pager

So, I had purchased an Alphapoc style pager (the typical Chinese clone on ebay Model GP2009N)
and it works great.... But one thing I noted, supposedly if you add RIC 224 in slot 8 it will automatically set the pager's clock to local time.

Well, turns out that's not QUITE accurate.... It will set it to the local time of whatever DAPNET host you're connecting to... so in my case, it was setting my pager to the time in Germany.... I could use RIC 216 and have it use UTC.... But I REALLY wanted it to set to LOCAL time of my Pi-Star hotspot.... so, here's the solution I came up with.

First... I blacklisted 224 in the POCSAG config in Pi-Star
Then I placed the POCSAGLocalTime python program in /usr/local/bin and chmod it to 755

I then added the following line to /etc/crontab to run the script every 4 minutes... this mimics the DAPNET sending of RIC 224 every 4 minutes.

*/4 *   * * *   root    /usr/local/bin/POCSAGLocalTime > /dev/null

So, what I've effectively done is blocked the DAPNET RIC224 Germany local time message, and replaced it with my own using my Pi-Star's ACTUAL local time... 
now my pager gets its TRUE local time
