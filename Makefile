
include config.mak

TAG ?= gcc-$(GCC_VER)-musl-$(MUSL_VER)

config.md:
	@echo "## Configurations:" 							     > $@
	@echo ""                                                >> $@
	@echo "- GCC v$(GCC_VER): $(GCC_CONFIG)"                >> $@
	@echo "- musl v$(MUSL_VER): $(MUSL_CONFIG)"             >> $@
	@echo "- binutils v$(BINUTILS_VER): $(BINUTILS_CONFIG)" >> $@

tag:
	git tag -a $(TAG) -m $(TAG) --force
	git push origin $(TAG) --force
	echo $(TAG) > .tag

clean:
	$(MAKE) -C musl-cross-make clean
