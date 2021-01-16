#!/bin/sh

# Initialize gpios for infovision systems
# using the generic gpio control system.

# This file originates from MG

source /etc/boemb/common.sh

umask 077

BASEPATH=/sys/class/gpio

gpio_export()
{
	echo $1 > $BASEPATH/export;
}

gpio_set_out()
{
	echo out > $BASEPATH/gpio$1/direction;
}

gpio_set_in()
{
	echo in > $BASEPATH/gpio$1/direction;
}

gpio_set_value()
{
	echo $2 > $BASEPATH/gpio$1/value;
}

gpio_link_name()
{
	ln -s $BASEPATH/gpio$1/value /dev/$2;
}

gpio_active_low()
{
	echo $2 > $BASEPATH/gpio$1/active_low;
}

#
#	$1 - GPIO No
#	$2 - GPIO direction
#	$3 - GPIO Default value
#	$4 - GPIO active low
#	$5 - GPIO symlink target
#
gpio_setup()
{
	GPIO_NO=$1;
	GPIO_DIRECTION=$2;
	GPIO_DEF_VALUE=$3;
	GPIO_ACTIVE_LOW=$4;
	GPIO_SYMLINK_TARGET=$5;
	info "Exporting gpio $GPIO_NO";
	gpio_export $GPIO_NO;
	info "   Setting active low to $GPIO_ACTIVE_LOW";
	gpio_active_low $GPIO_NO $GPIO_ACTIVE_LOW;
	if [ "$GPIO_DIRECTION" = "out" ]
	then
		info "   Setting direction to out";
		gpio_set_out $GPIO_NO;
		info "   Setting value to $GPIO_DEF_VALUE";
		gpio_set_value $GPIO_NO $GPIO_DEF_VALUE;
	else
		info "   Setting direction to in";
		gpio_set_in $GPIO_NO;
	fi
	info "gpio_init: Creating gpio $GPIO_SYMLINK_TARGET";
	gpio_link_name $GPIO_NO $GPIO_SYMLINK_TARGET;
}

# Get i2c-kempld gpio
kempldgpio=$(grep  i2c-kempld /sys/bus/i2c/devices/i2c*/name | sed 's/\/name:i2c-kempld//g')

# First we will try to load the drivers for our pcf8574
# i2c bus expanders
echo pcf8574 0x20 > $kempldgpio/new_device
echo pcf8574 0x21 > $kempldgpio/new_device
echo pcf8574 0x22 > $kempldgpio/new_device
echo pcf8574 0x23 > $kempldgpio/new_device

# If this worked we should be able to access the devices
# now and map their gpios to our system.
# On the test system the gpios start at number 224
# we will take that as granted.
# NOBA : On our MG, it seems to be 216
GPIO_BASE_NO=472

start() {
	#
	# Setting up graphic adjustment gpios
	#
	if [ -e "${BASEPATH}/gpiochip$(expr $GPIO_BASE_NO + 0)" ]; then
	  gpio_setup $(expr $GPIO_BASE_NO + 0) out 0 0 gfx1-trim;
	  gpio_setup $(expr $GPIO_BASE_NO + 1) out 0 0 gfx1-CCT1;
	  gpio_setup $(expr $GPIO_BASE_NO + 2) out 0 0 gfx1-CCT2;
	  gpio_setup $(expr $GPIO_BASE_NO + 3) out 1 0 gfx1-HPD;
	  gpio_setup $(expr $GPIO_BASE_NO + 4) out 0 0 gfx2-trim;
	  gpio_setup $(expr $GPIO_BASE_NO + 5) out 0 0 gfx2-CCT1;
	  gpio_setup $(expr $GPIO_BASE_NO + 6) out 0 0 gfx2-CCT2;
	  gpio_setup $(expr $GPIO_BASE_NO + 7) out 1 0 gfx2-HPD;
	else
		info "Unable to find gpiochip$(expr $GPIO_BASE_NO + 0)"
	fi


	#
	# Setting up serial control gpios
	#
	if [ -e "${BASEPATH}/gpiochip$(expr $GPIO_BASE_NO + 8)" ]; then
	  gpio_setup $(expr $GPIO_BASE_NO + 8) out 0 0 s1-rs232_rs485;
	  gpio_setup $(expr $GPIO_BASE_NO + 9) out 0 0 s1-term-off_on;
	  gpio_setup $(expr $GPIO_BASE_NO + 10) out 0 1 s1-duplex-half_full;
	  gpio_setup $(expr $GPIO_BASE_NO + 11) out 0 0 s2-rs232_rs485;
	  gpio_setup $(expr $GPIO_BASE_NO + 12) out 0 0 s2-term-off_on;
	  gpio_setup $(expr $GPIO_BASE_NO + 13) out 0 1 s2-duplex-half_full;

	  #
	  # Setting up Button and Update LED
	  #
	  gpio_setup $(expr $GPIO_BASE_NO + 14) in 0 1 button;
	  gpio_setup $(expr $GPIO_BASE_NO + 15) out 0 1 led-update;
	else
		info "Unable to find gpiochip$(expr $GPIO_BASE_NO + 8)"
	fi

	#
	# Setting up inputs 0-3
	#
	if [ -e "${BASEPATH}/gpiochip$(expr $GPIO_BASE_NO + 16)" ]; then
	  gpio_setup $(expr $GPIO_BASE_NO + 16) in 0 1 input-0;
	  gpio_setup $(expr $GPIO_BASE_NO + 17) in 0 1 input-1;
	  gpio_setup $(expr $GPIO_BASE_NO + 18) in 0 1 input-2;
	  gpio_setup $(expr $GPIO_BASE_NO + 19) in 0 1 input-3;

	  #
	  # Setting up outputs 0-3
	  #
	  gpio_setup $(expr $GPIO_BASE_NO + 20) in 0 1 output-0;
	  gpio_setup $(expr $GPIO_BASE_NO + 21) in 0 1 output-1;
	  gpio_setup $(expr $GPIO_BASE_NO + 22) in 0 1 output-2;
	  gpio_setup $(expr $GPIO_BASE_NO + 23) in 0 1 output-3;
	else
		info "Unable to find gpiochip$(expr $GPIO_BASE_NO + 16)"
	fi

	#
	# Setting up misc gpios
	#
	if [ -e "${BASEPATH}/gpiochip$(expr $GPIO_BASE_NO + 24)" ]; then
	  gpio_setup $(expr $GPIO_BASE_NO + 24) out 0 1 led-gps;
	  gpio_setup $(expr $GPIO_BASE_NO + 25) out 0 1 led-vpn;
	  gpio_setup $(expr $GPIO_BASE_NO + 31) out 0 1 rs485-term;
	else
		info "Unable to find gpiochip$(expr $GPIO_BASE_NO + 24)"
	fi

	#
	# Setting up gps antenna gpios
	#
	if [ -e "${BASEPATH}/gpiochip$(expr $GPIO_BASE_NO + 32)" ]; then
	  gpio_setup $(expr $GPIO_BASE_NO + 32) in 0 1 gps-short;
	  gpio_setup $(expr $GPIO_BASE_NO + 33) in 0 1 gps-current-flow;
	else
		info "Unable to find gpiochip$(expr $GPIO_BASE_NO + 32)"
	fi
}

stop() {
	stat_finish $?
}
restart() {
	stop
	start
}

case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  restart|reload)
  	restart
	;;
  *)
	echo $"Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?

