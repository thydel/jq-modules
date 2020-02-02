top:; @date

Makefile:;

local := /usr/local
libjq := $(local)/lib/jq

libs := Set flow-matrix

installed := $(libs:%=$(libjq)/%.jq)
$(installed): $(libjq)/%.jq : %.jq; install $< $@

install: $(libjq)/.stone $(installed)
.PHONY: install

%/.stone:; mkdir -p $(@D); touch $@
