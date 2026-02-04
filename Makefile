
include config.mak

config.md:
	@echo "## Configurations:" 							     > $@
	@echo ""                                                >> $@
	@echo "- GCC v$(GCC_VER): $(GCC_CONFIG)"                >> $@
	@echo "- musl v$(MUSL_VER): $(MUSL_CONFIG)"             >> $@
	@echo "- binutils v$(BINUTILS_VER): $(BINUTILS_CONFIG)" >> $@

clean:
	$(MAKE) -C musl-cross-make clean
