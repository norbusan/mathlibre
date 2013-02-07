all: build
config: clean
	lb config \
        --apt-secure false \
	--mirror-bootstrap "http://localhost:3142/ftp.jp.debian.org/debian/" \
	--mirror-binary "http://localhost:3142/ftp.jp.debian.org/debian/" \
	--mirror-chroot "http://localhost:3142/ftp.jp.debian.org/debian/" \
        --parent-mirror-binary "http://ftp.jp.debian.org/debian/" \
	--archive-areas "main contrib non-free" \
	--parent-archive-areas "main contrib non-free" \
	--binary-images iso \
	--bootappend-live \
		"boot=live config quiet splash persistent quickreboot \
		live-config.utc=no \
		live-config.locales=ja_JP.UTF-8 \
		live-config.timezone=Asia/Tokyo \
		live-config.keyboard-model=jp106 \
		live-config.keyboard-layouts=jp"

build: config
	sudo lb build
	ls -l binary*.iso >> binary.hybrid.iso.ls-l
clean:
	sudo lb clean
distclean: clean
 	#sudo lb clean --purge
	sudo rm -f *.iso *.img *.list *.packages *.buildlog *.md5sum
