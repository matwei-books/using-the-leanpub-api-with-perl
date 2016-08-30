# Makefile for leanpub / dropbox

PERLWEBSERVICELEANPUB = ../perl-WebService-Leanpub

BOOK = Book.txt
PREVIEW = Subset.txt
SAMPLE = Sample.txt

MANUSCRIPT = manuscript
TMARKUA    = t/tmp

MANPAGES = $(MANUSCRIPT)/module.md $(MANUSCRIPT)/cli.md

DROPBOXFILES = $(MANUSCRIPT)/$(BOOK) \
               $(MANUSCRIPT)/$(PREVIEW) \
               $(MANUSCRIPT)/$(SAMPLE) \
               $(MANUSCRIPT)/preface.md \
               $(MANUSCRIPT)/chapter01.md \
               $(MANUSCRIPT)/chapter02.md \
               $(MANUSCRIPT)/backmatter.md \
               $(MANUSCRIPT)/appendix01.md \
               $(MANUSCRIPT)/appendix02.md \
               $(MANUSCRIPT)/module.md \
               $(MANUSCRIPT)/cli.md \
               $(MANUSCRIPT)/images/title_page.png \
#
MARKUASRC = $(MANUSCRIPT)/preface.markua \
            $(MANUSCRIPT)/chapter01.markua \
            $(MANUSCRIPT)/chapter02.markua \
            $(MANUSCRIPT)/backmatter.markua \
            $(MANUSCRIPT)/appendix01.markua \
            $(MANUSCRIPT)/appendix02.markua \
            $(MANUSCRIPT)/module.markua \
            $(MANUSCRIPT)/cli.markua \
#
MARKUATEST = $(TMARKUA)/headings.markua \
             $(TMARKUA)/lists.markua \
             $(TMARKUA)/paragraph.markua \
#
	     
IMAGES = \
#

$(TMARKUA)/%.markua: t/markdown/%.md
	bin/markdown2markua < $< > $@

%.markua: %.md bin/markdown2markua
	bin/markdown2markua < $< > $@

$(MANUSCRIPT)/%.md: %.md
	cp $< $@

$(MANUSCRIPT)/%-empty.md: %.md
	grep '^#' $< | grep -v '## Tip' | sed -e 's/^/\n/' > $@

$(MANUSCRIPT)/%.txt: %.txt
	cp $< $@

$(MANUSCRIPT)/code/%: code/% $(MANUSCRIPT)/code
	cp $< $@

$(MANUSCRIPT)/code: $(MANUSCRIPT)
	mkdir $(MANUSCRIPT)/code

$(MANUSCRIPT)/images/%.jpg: images/%.jpg
	cp $< $@

$(MANUSCRIPT)/images/%.png: images/%.png
	cp $< $@

$(MANUSCRIPT)/module.md: $(PERLWEBSERVICELEANPUB)/lib/WebService/Leanpub.pm
	pod2markdown < $< | perl -p -e 's/^#/##/' > $@

$(MANUSCRIPT)/cli.md: $(PERLWEBSERVICELEANPUB)/bin/leanpub
	pod2markdown < $< | perl -p -e 's/^#/##/' > $@

all:

clean: clean_test

clean_test:
	rm -f $(MARKUATEST)

dropbox: $(DROPBOXFILES)

git-push:
	git push

man-pages: $(MANPAGES)

markua: $(MARKUASRC)
	perl -pi.bak -e 's/\.md$$/.markua/' $(MANUSCRIPT)/Book.txt

preview: git-push
	leanpub preview

status:
	leanpub job_status

summary:
	leanpub summary

test:	clean_test $(TMARKUA) $(MARKUATEST)
	diff -ru t/markua $(TMARKUA)

$(TMARKUA):
	mkdir -p $(TMARKUA)

# end of Makefile
