# vim:set ts=8 sw=8 noet ai:
BASEDIR=$(shell pwd)
OUTDIR=$(BASEDIR)/build
DEPDIR=$(BASEDIR)/deps
SCHEME=Debug
ifeq ($(REL),1)
SCHEME=Release
endif

GYP_DEP=$(DEPDIR)/gyp
GYP_URL=https://chromium.googlesource.com/external/gyp.git
NINJA_DEP=$(DEPDIR)/ninja
NINJA_URL=https://github.com/martine/ninja.git
NINJA_OPTS=
ifeq ($(V),1)
NINJA_OPTS=-v
endif

TARGET=binfile

all: $(TARGET)

$(TARGET): $(OUTDIR)
	@cd $(OUTDIR)/out/$(SCHEME) && $(NINJA_DEP)/ninja $(NINJA_OPTS)

$(GYP_DEP):
	git clone --depth 1 $(GYP_URL) $(GYP_DEP)

$(NINJA_DEP):
	git clone --depth 1 $(NINJA_URL) $(NINJA_DEP)
	cd $(NINJA_DEP) && python bootstrap.py

$(OUTDIR): $(GYP_DEP) $(NINJA_DEP)
	$(GYP_DEP)/gyp all.gyp --depth=. -f ninja --generator-output=$(OUTDIR)

clean:
	rm -rf $(OUTDIR)

distclean: clean
	rm -rf $(DEPDIR)

over: clean all

run: $(TARGET)
	@$(OUTDIR)/out/$(SCHEME)/$(TARGET)

.PHONY: all $(TARGET) clean distclean over run

