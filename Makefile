
TARGET = $(shell uname -m)-linux-musl

SUBDIR = musl-cross-make
OUTPUT = $(SUBDIR)/output
BUILDER = v0.9.11

TAG = gcc-$(GCC_VER)-musl-$(MUSL_VER)
LOG = $(TARGET).log

include config.mak

all: config.md
	# prepare builder
	git submodule set-branch -b $(BUILDER) $(SUBDIR)
	git submodule update --init --recursive --force
	rm -rf $(SUBDIR)/sources
	ln -sfv ../sources $(SUBDIR)/sources
	ln -sfv ../config.mak $(SUBDIR)/config.mak
	find sources -type f -exec touch {} +
	touch config.mak
	# start build
	{ \
		echo "**** $(shell date) ****"; \
		$(MAKE) -C $(SUBDIR) TARGET=$(TARGET); \
		$(MAKE) -C $(SUBDIR) TARGET=$(TARGET) install; \
	} | tee $(LOG)
	# postprocessing
	$(MAKE) zip

config.md: config.mak
	@echo "## Configurations:" 							     > $@
	@echo ""                                                >> $@
	@echo "- $(COMMON_CONFIG)" 								>> $@
	@echo ""                                                >> $@
	@echo "- GCC v$(GCC_VER): $(GCC_CONFIG)"                >> $@
	@echo "- musl v$(MUSL_VER): $(MUSL_CONFIG)"             >> $@
	@echo ""                                                >> $@
	@echo "- libraries: binutils v$(BINUTILS_VER), gmp v$(GMP_VER), mpc v$(MPC_VER), mpfr v$(MPFR_VER), isl v$(ISL_VER)" >> $@

tag:
	git tag -a $(TAG) -m $(TAG) --force
	git push origin $(TAG) --force

zip:
	# no libtool files
	find $(OUTPUT) -name "*.la" -exec rm -f {} +
	# zip toolchain
	tar -C $(OUTPUT) -cf $(TARGET).tar.xz .
	# zip log file
	gzip -f $(LOG)

clean:
	rm -rf $(OUTPUT)
	rm -rf $(TARGET).*
