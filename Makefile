all: build

config: clean
	lb config \
	--apt-http-proxy "http://localhost:3142" \
	--mirror-bootstrap "http://ftp.jp.debian.org/debian/" \
	--mirror-chroot "http://ftp.jp.debian.org/debian/" \
	--parent-mirror-binary "http://ftp.jp.debian.org/debian/" \
	--archive-areas "main contrib non-free" \
	--parent-archive-areas "main contrib non-free" \
	--apt-options "--yes -oAcquire::Check-Valid-Until=false" \
	--apt-secure false \
	--bootappend-live "boot=live config quiet splash" \
        --linux-packages "linux-image linux-headers" \
	--architectures amd64 --linux-flavours amd64 --debian-installer live \
	--win32-loader false
#	--binary-images iso 

build: config
	sudo lb build
	ls -l binary*.iso >> iso.ls-l


clean:
	sudo lb clean
	rm -f config/package-lists/lang.*.list.chroot
	rm -f config/etc/emacs/site-start.d/99lang.*.el

distclean: clean
	#sudo lb clean --purge
	sudo rm -f *.iso *.img *.list *.packages *.buildlog *.md5sum

us: build

config-ja: config
	sh lang/ja
ja: config-ja
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

config-ko: config
	sh lang/ko
ko: config-ko
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

config-cn: config
	sh lang/cn
cn: config-cn
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

config-tw: config
	sh lang/tw
tw: config-tw
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

