# Makefile for leanpub / dropbox

BOOK = Book.txt
PREVIEW = Subset.txt
SAMPLE = Sample.txt

MANUSCRIPT = manuscript

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
IMAGES = \
#
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

$(MANUSCRIPT)/module.md: ../lib/WebService/Leanpub.pm
	bin/pod2markdown < $< | perl -p -e 's/^#/##/' > $@

$(MANUSCRIPT)/cli.md: ../bin/leanpub
	bin/pod2markdown < $< | perl -p -e 's/^#/##/' > $@

all:

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

# end of Makefile
