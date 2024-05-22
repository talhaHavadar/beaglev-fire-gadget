STAGEDIR ?= "$(CURDIR)/stage"
DESTDIR ?= "$(CURDIR)/install"
ARCH ?= riscv

ifeq ($(ARCH),riscv)
        MKIMAGE_ARCH := riscv
else
        $(error Build architecture is not supported)
endif

classic: gadget boot-script

boot-script: $(STAGEDIR) $(DESTDIR)/blobs
	cp extras/bootscript/bootscr.beaglev.fire > $(STAGEDIR)/bootscr.beaglev.fire
	mkimage  -A $(MKIMAGE_ARCH) -O linux -T script -C none -n "boot script" \
		-d $(STAGEDIR)/bootscr.beaglev.fire $(DESTDIR)/blobs/boot.scr


gadget:
	mkdir -p $(DESTDIR)/meta
	cp gadget.yaml $(DESTDIR)/meta/
	cp gadget.yaml $(DESTDIR)/

clean:
	-rm -rf $(DESTDIR)
	-rm -rf $(STAGEDIR)

$(STAGEDIR):
	mkdir -p $(STAGEDIR)

$(STAGEDIR)/blobs:
	mkdir -p $(STAGEDIR)/blobs

$(DESTDIR)/configs:
	mkdir -p $(DESTDIR)/configs

$(DESTDIR)/blobs:
	mkdir -p $(DESTDIR)/blobs
