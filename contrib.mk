# -*- mode: makefile-gmake -*-

contrib-subdirs := airline config integration layer scheme
contrib-outdirs := $(OUTDIR)/contrib $(contrib-subdirs:%=$(OUTDIR)/contrib/%)
contrib-srcfiles := $(wildcard contrib/*.bash $(contrib-subdirs:%=contrib/%/*.bash))
contrib-datfiles := $(wildcard contrib/*.dat $(contrib-subdirs:%=contrib/%/*.dat))
contrib-docfiles := $(wildcard contrib/*.md $(contrib-subdirs:%=contrib/%/*.md))
contrib-outfiles := $(contrib-srcfiles:contrib/%=$(OUTDIR)/contrib/%) $(contrib-datfiles:contrib/%=$(OUTDIR)/contrib/%)

# files
outdirs += $(contrib-outdirs)
outfiles += $(contrib-outfiles)
$(OUTDIR)/contrib/%.bash: contrib/%.bash | $(contrib-outdirs)
	$(CP) $< $@
$(OUTDIR)/contrib/%.dat: contrib/%.dat | $(contrib-outdirs)
	$(CP) $< $@

define LinkOldIntegration
outfiles += $$(OUTDIR)/contrib/$1.bash
$$(OUTDIR)/contrib/$1.bash: contrib/integration/$1.bash
	ln -sf integration/$1.bash $$@
endef
$(eval $(call LinkOldIntegration,bash-preexec))
$(eval $(call LinkOldIntegration,fzf-completion))
$(eval $(call LinkOldIntegration,fzf-git))
$(eval $(call LinkOldIntegration,fzf-initialize))
$(eval $(call LinkOldIntegration,fzf-key-bindings))

# docs
outdirs += $(OUTDIR)/doc/contrib $(OUTDIR)/doc/contrib/integration
outfiles-license += $(OUTDIR)/doc/contrib/LICENSE
ifneq ($(USE_DOC),no)
  outfiles-doc += $(contrib-docfiles:contrib/%=$(OUTDIR)/doc/contrib/%)
endif

# Note (workaround for make-3.81): 当初 $(OUTDIR)/doc/contrib/% に対してルール
# を記述していたが make-3.81 に於いて正しく適用されない事が分かった。仕方がない
# ので LICENSE と %.md の二つの規則に分けて書く事にする。
$(OUTDIR)/doc/contrib/LICENSE: contrib/LICENSE | $(OUTDIR)/doc/contrib
	$(CP) $< $@
$(OUTDIR)/doc/contrib/%.md: contrib/%.md | $(OUTDIR)/doc/contrib $(OUTDIR)/doc/contrib/integration
	bash make_command.sh install $< $@
