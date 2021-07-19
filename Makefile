obj-m += tda7802.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

.PHONY: install
install: $(obj-m)
	cp $(obj-m) /lib/modules/$(shell uname -r)/kernel/sound/soc/codecs/$(obj-m)
	dtc -I dts -O dtb -o /boot/overlays/tda7802-stereo.dtbo tda7802.dts
	echo "dtoverlay=tda7802-stereo" >> /boot/config.txt

.PHONY: uninstall
uninstall: $(obj-m)
	rm /lib/modules/$(shell uname -r)/kernel/sound/soc/codecs/$(obj-m)
	rm /boot/overlays/tda7802-stereo.dtbo tda7802.dts


