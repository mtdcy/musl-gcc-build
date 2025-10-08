
include config.mak

config.md:
	@echo "## Configurations:" 						> $@
	@echo ""                                       >> $@
	@echo "- COMMON_CONFIG   : $(COMMON_CONFIG)"   >> $@
	@echo "- GCC_CONFIG      : $(GCC_CONFIG)"      >> $@
	@echo "- MUSL_CONFIG     : $(MUSL_CONFIG)"     >> $@
	@echo "- BINUTILS_CONFIG : $(BINUTILS_CONFIG)" >> $@
