# Copyright (C) 2012-2020 SUSE Software Solutions Germany GmbH
#
# Author:
# Frank Sundermeyer <fsundermeyer at opensuse dot org>
#
# METAFILE generation for DAPS
#
# Please submit feedback or patches to
# <fsundermeyer at opensuse dot org>
#
# for targets html and pdf
#
STYLEMETA := $(DAPSROOT)/daps-xslt/common/svn2docproperties.xsl

ifeq "$(META)" "1"
  # Issue a warning when specifying --meta without profiling
  ifndef PROFILE_URN
    $(warning $(shell ccecho "warn" "Did not find a profiling URN. Displaying meta information only works with profiling."))
  endif
  ifdef USESVN
    # meta information (author, last changed, etc)
    METASTRING   := --param "use.meta=1"

    $(PROFILEDIR)/METAFILE: $(TMP_DIR)/.$(DOCNAME)_docprops.xml
      ifeq "$(VERBOSITY)" "2"
	@ccecho "info"  "Generating $@ ..."
      endif
	$(XSLTPROC) -o $@ --stylesheet $(STYLEMETA) --file $< $(XSLTPROCESSOR)
  endif
endif

#-----
# Using PHONY here to make sure this file is generated every time, because
# there is no way to tell if the SVN properties have changed since
# last generating this file
#
PHONY: $(TMP_DIR)/.$(DOCNAME)_docprops.xml
$(TMP_DIR)/.$(DOCNAME)_docprops.xml: | $(TMP_DIR)
$(TMP_DIR)/.$(DOCNAME)_docprops.xml: $(DOCFILES)
	svn pl -v --xml $(DOCFILES) > $@
