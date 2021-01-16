repo pour faire une image BOEMB avec openembedded 

su - xxx
cd /BB/bornes
git clone -b morty git://git.yoctoproject.org/poky.git poky-morty
cd poky-morty
git clone -b morty git://git.openembedded.org/meta-openembedded
git clone -b morty https://github.com/meta-qt5/meta-qt5.git
git clone -b morty git://git.yoctoproject.org/meta-raspberrypi
git clone https://github.com/OSSystems/meta-browser
mkdir -p BOTER/build/conf
cd boter
git clone https://github.com/jpsuter/meta-boemb.git
source poky-morty/oe-init-build-env BOTER/build/
cp /BB/bornes/BOTER/meta-boemb/conf/bblayers.conf conf/
cp /BB/bornes/BOTER/meta-boemb/conf/local.conf conf/
bitbake boemb-image

attendre quelques heures ;-)

pour la configuration :
mosquitto_pub -h xxx.t-l.ch -r -t TL/BOTER/00000000267313c7/config -m '{"IP":"10.3.219.93","NAME":"BIV-993","URL":"http://127.0.0.1/player/#/boter/landscape/leb/11540478340105011","Screen_L":"1920","Screen_H":"1080"}'

This layer depends on:

    URI: git://git.yoctoproject.org/poky.git
    branch: morty
    revision: HEAD
    commit: 8a96509

    URI: git://git.openembedded.org/meta-openembedded
    branch: morty
    revision: HEAD
    commit: fe5c833

    URI: https://github.com/meta-qt5/meta-qt5.git
    branch: morty
    revision: HEAD
    commit: 3601fd2

    URI: git://git.yoctoproject.org/meta-raspberrypi 
    branch: morty
    revision: HEAD
    commit: 380bf2f

    url = https://github.com/OSSystems/meta-browser
    branch "master"

    url = https://github.com/imyller/meta-nodejs.git
    branch "master"
    for building "tl-bornes"

    url = https://github.com/imyller/meta-nodejs-contrib
    branch "master"
    for building "tl-bornes" (bower)


    based on meta-rpi layer maintained by Scott Ellis <scott@jumpnowtek.com>

    adapted for tl for "bornes IV" by JP Suter <suter.j-p@t-l.ch> <jps@jpsuter.ch>
