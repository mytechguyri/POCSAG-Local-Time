#!/bin/bash
sudo cp POCSAGLocalTime /usr/local/bin/
sudo chown mmdvm:mmdvm /usr/local/bin/POCSAGLocalTime
sudo chmod +x /usr/local/bin/POCSAGLocalTime
sudo cp pocsaglocaltime.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start pocsaglocaltime
sudo systemctl enable pocsaglocaltime
sudo systemctl enable systemd-timesyncd.service
