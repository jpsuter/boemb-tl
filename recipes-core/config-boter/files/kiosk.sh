export DISPLAY=:0
export GOOGLE_API_KEY="no"
export GOOGLE_DEFAULT_CLIENT_ID="no"
export GOOGLE_DEFAULT_CLIENT_SECRET="no"
source /opt/config/boemb.cfg
/usr/bin/chromium/chrome --window-size=$Screen_L,$Screen_H -remote-debugging-port=9999 --kiosk $URL
