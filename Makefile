#- makefile -
# vim: ft=make:noexpandtab:ts=2:sw=2

INITRAMDIR = /etc/initramfs-tools
TOOLDIR = /usr/local/bin

all:
	echo "as root call"
	echo "	make install"

install:
	@set -e; \
	for f in hooks/* scripts/*; do \
		dir="$(INITRAMDIR)/$${f%/*}"; \
		dest="$(INITRAMDIR)/$${f}"; \
		echo "INSTALL $${f} -> $${dest}"; \
		mkdir -p "$$dir"; \
		cp -a "$$f" "$$dest"; \
		chown root: "$$dest"; \
		chmod 744 "$$dest"; \
	done; \
	for f in tools/*; do \
		dir="$(TOOLDIR)/"; \
		dest="$(TOOLDIR)/$${f#*/}"; \
		echo "INSTALL $${f} -> $${dest}"; \
		mkdir -p "$$dir"; \
		cp -a "$$f" "$$dest"; \
		chown root: "$$dest"; \
		chmod 744 "$$dest"; \
	done

update:
	update-initramfs -k$$(uname -r) -u
