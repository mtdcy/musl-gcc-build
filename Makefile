
include config.mak

dump_config:
	@echo "COMMON_CONFIG   : $(COMMON_CONFIG)"    > .configs
	@echo "GCC_CONFIG      : $(GCC_CONFIG)"      >> .configs
	@echo "MUSL_CONFIG     : $(MUSL_CONFIG)"     >> .configs
	@echo "BINUTILS_CONFIG : $(BINUTILS_CONFIG)" >> .configs
