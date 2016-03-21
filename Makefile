#
# Manage generated versions of nfsv4-rpcrdma-version-two
#

# Tools
ENSCRIPT := enscript -f Courier@10 --margins 76::76: -B -q -p
PS2PDF := ps2pdf
RM := rm -f
XML2RFC := xml2rfc
IDNITS := ../idnits-2.13.02/idnits

# docName
AUTHOR := cel
NAME := nfsv4-rpcrdma-version-two
VERSION := 00
DOCNAME := draft-$(AUTHOR)-$(NAME)-$(VERSION)

# Source
SOURCE := $(NAME).xml

# Gen
TXT := $(DOCNAME).txt
PS := $(DOCNAME).ps
PDF := $(DOCNAME).pdf
HTML := $(DOCNAME).html
XML := $(DOCNAME).xml

all: $(TXT) $(PS) $(PDF) $(HTML) $(XML)

autogen.xml: $(SOURCE) references/reference.*.xml authors/author*.xml
	sed -e s/DOCNAMEVAR/$(DOCNAME)/g < $(SOURCE) > $@

$(XML): autogen.xml
	$(XML2RFC) $^ --exp -o $@

$(TXT): $(XML)
	$(XML2RFC) $^ --text -o $@

$(HTML): $(XML)
	$(XML2RFC) $^ --html -o $@

$(PS): $(TXT)
	$(ENSCRIPT) $@ $^

$(PDF): $(PS)
	$(PS2PDF) $^ $@

.PHONY: idnits clean

idnits: $(TXT)
	$(IDNITS) --verbose $^

clean:
	$(RM) draft-* autogen.xml
