STAGEDIR ?= "$(CURDIR)/stage"
DESTDIR ?= "$(CURDIR)/install"
ARCH ?= riscv

ifeq ($(ARCH),riscv)
        MKIMAGE_ARCH := riscv
else if ($(ARCH),amd64)
        MKIMAGE_ARCH := riscv
else
        $(error Build architecture is not supported)
endif

classic: gadget boot-assets uboot

boot-assets: boot-script
	cp extras/device-trees/* $(DESTDIR)/assets
	cp extras/kernel/* $(DESTDIR)/assets

boot-script: $(STAGEDIR) $(DESTDIR)/assets
	cp extras/bootscript/bootscr.beaglev.fire $(STAGEDIR)/bootscr.beaglev.fire
	mkimage  -A $(MKIMAGE_ARCH) -O linux -T script -C none -n "boot script" \
		-d $(STAGEDIR)/bootscr.beaglev.fire $(DESTDIR)/assets/boot.scr

uboot: $(DESTDIR)/extras
	cp extras/payload.bin $(DESTDIR)/extras

gadget:
	mkdir -p $(DESTDIR)/meta
	cp gadget.yaml $(DESTDIR)/meta/
	cp gadget.yaml $(DESTDIR)/

clean:
	-rm -rf $(DESTDIR)
	-rm -rf $(STAGEDIR)

$(STAGEDIR):
	mkdir -p $(STAGEDIR)

$(STAGEDIR)/extras:
	mkdir -p $(STAGEDIR)/extras

$(STAGEDIR)/assets:
	mkdir -p $(STAGEDIR)/assets

$(DESTDIR)/configs:
	mkdir -p $(DESTDIR)/configs

$(DESTDIR)/assets:
	mkdir -p $(DESTDIR)/assets

$(DESTDIR)/extras:
	mkdir -p $(DESTDIR)/extras
