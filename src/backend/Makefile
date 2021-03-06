#-------------------------------------------------------------------------
#
# Makefile--
#    Makefile for the postgres backend (and the postmaster)
#
# Copyright (c) 1994, Regents of the University of California
#
#
# IDENTIFICATION
#    $Header: /usr/local/cvsroot/postgres95/src/backend/Makefile,v 1.2.2.1 1996/08/19 13:46:19 scrappy Exp $
#
#-------------------------------------------------------------------------

#
# The following turns on intermediate linking of partial objects to speed
# the link cycle during development. (To turn this off, put "BIGOBJS=false"
# in your custom makefile, ../Makefile.custom.)
BIGOBJS= true


PROG=	postgres

MKDIR=	../mk
include $(MKDIR)/postgres.mk


include $(CURDIR)/access/Makefile.inc
include $(CURDIR)/bootstrap/Makefile.inc
include $(CURDIR)/catalog/Makefile.inc
include $(CURDIR)/commands/Makefile.inc
include $(CURDIR)/executor/Makefile.inc
include $(CURDIR)/include/Makefile.inc
include $(CURDIR)/lib/Makefile.inc
include $(CURDIR)/libpq/Makefile.inc
include $(CURDIR)/main/Makefile.inc
include $(CURDIR)/nodes/Makefile.inc
include $(CURDIR)/optimizer/Makefile.inc
include $(CURDIR)/parser/Makefile.inc
include $(CURDIR)/port/Makefile.inc
include $(CURDIR)/postmaster/Makefile.inc
include $(CURDIR)/regex/Makefile.inc
include $(CURDIR)/rewrite/Makefile.inc
include $(CURDIR)/storage/Makefile.inc
include $(CURDIR)/tcop/Makefile.inc
include $(CURDIR)/tioga/Makefile.inc
include $(CURDIR)/utils/Makefile.inc

SRCS:=	${SRCS_ACCESS} ${SRCS_BOOTSTRAP} $(SRCS_CATALOG) ${SRCS_COMMANDS} \
	${SRCS_EXECUTOR} $(SRCS_LIB) $(SRCS_LIBPQ) ${SRCS_MAIN} \
	${SRCS_NODES} ${SRCS_OPTIMIZER} ${SRCS_PARSER} ${SRCS_PORT} \
	$(SRCS_POSTMASTER) ${SRCS_REGEX} ${SRCS_REWRITE} ${SRCS_STORAGE} \
	${SRCS_TCOP} ${SRCS_UTILS} 

ifeq ($(BIGOBJS), true)
OBJS= ACCESS.o BOOTSTRAP.o COMMANDS.o EXECUTOR.o MAIN.o MISC.o NODES.o \
	PARSER.o OPTIMIZER.o REGEX.o REWRITE.o STORAGE.o TCOP.o UTILS.o
CLEANFILES+= $(subst .s,.o,$(SRCS:.c=.o)) $(OBJS)
else
OBJS:= $(subst .s,.o,$(SRCS:%.c=$(objdir)/%.o))
CLEANFILES+= $(notdir $(OBJS))
endif

#############################################################################
#
# TIOGA stuff
#
ifdef TIOGA
SRCS+= $(SRCS_TIOGA) 
   ifeq ($(BIGOBJS), true)
TIOGA.o: 	$(SRCS_TIOGA:%.c=$(objdir)/%.o)
	$(make_partial)
OBJS+= TIOGA.o
CLEANFILES+= $(SRCS_TIOGA:%.c=%.o) TIOGA.o
   else
OBJS+= $(SRCS_TIOGA:%.c=$(objdir)/%.o)
   endif
endif


#############################################################################
#
# Compiling the postgres backend.
#
CFLAGS+=  -DPOSTGRESDIR='"$(POSTGRESDIR)"' \
	-DPGDATADIR='"$(DATADIR)"' \
	-I$(CURDIR)/. -I$(CURDIR)/$(objdir) \
	-I$(CURDIR)/include \
	-I$(CURDIR)/port/$(PORTNAME)

# turn this on if you prefer European style dates instead of American
# style dates
ifdef EUROPEAN_DATES
CFLAGS += -DEUROPEAN_STYLE
endif

# host based access flags
ifdef HBA
CFLAGS+= $(HBAFLAGS)
endif
 
#
# All systems except NEXTSTEP require the math library.
# Loader flags for system-dependent libraries are appended in
#	src/backend/port/$(PORTNAME)/Makefile.inc
#
ifneq ($(PORTNAME), next)
LDADD+=	-lm
endif

# kerberos flags
ifdef KRBVERS
CFLAGS+= $(KRBFLAGS)
LDADD+= $(KRBLIBS)
endif

# statically link in libc for linux
ifeq ($(PORTNAME), linux)
LDADD+= -lc
endif

# the following is special for Reliant UNIX SVR4 (formerly SINIX)
ifeq ($(PORTNAME), svr4)
LDFLAGS+= -LD-Blargedynsym
endif

postgres: $(POSTGRES_DEPEND) $(OBJS) $(EXPORTS)
	$(CC) $(LDFLAGS) -o $(objdir)/$(@F) $(addprefix $(objdir)/,$(notdir $(OBJS))) $(LDADD)

# Make this target first if you are doing a parallel make.
# The targets in 'first' need to be made sequentially because of dependencies.
# Then, you can make 'all' with parallelism turned on.
first: $(POSTGRES_DEPEND)


#############################################################################
#
# Partial objects for platforms with slow linkers.
#
ifeq ($(BIGOBJS), true)

OBJS_ACCESS:=	   $(SRCS_ACCESS:%.c=$(objdir)/%.o)
OBJS_BOOTSTRAP:=   $(SRCS_BOOTSTRAP:%.c=$(objdir)/%.o)
OBJS_CATALOG:=	   $(SRCS_CATALOG:%.c=$(objdir)/%.o)
OBJS_COMMANDS:=	   $(SRCS_COMMANDS:%.c=$(objdir)/%.o)
OBJS_EXECUTOR:=	   $(SRCS_EXECUTOR:%.c=$(objdir)/%.o)
OBJS_MAIN:=	   $(SRCS_MAIN:%.c=$(objdir)/%.o)
OBJS_POSTMASTER:=  $(SRCS_POSTMASTER:%.c=$(objdir)/%.o)
OBJS_LIB:=	   $(SRCS_LIB:%.c=$(objdir)/%.o)
OBJS_LIBPQ:=	   $(SRCS_LIBPQ:%.c=$(objdir)/%.o)
OBJS_PORT:=	   $(addprefix $(objdir)/,$(subst .s,.o,$(SRCS_PORT:.c=.o)))
OBJS_NODES:=	   $(SRCS_NODES:%.c=$(objdir)/%.o)
OBJS_PARSER:=	   $(SRCS_PARSER:%.c=$(objdir)/%.o)
OBJS_OPTIMIZER:=   $(SRCS_OPTIMIZER:%.c=$(objdir)/%.o)
OBJS_REGEX:=	   $(SRCS_REGEX:%.c=$(objdir)/%.o)
OBJS_REWRITE:=	   $(SRCS_REWRITE:%.c=$(objdir)/%.o)
OBJS_STORAGE:=	   $(SRCS_STORAGE:%.c=$(objdir)/%.o)
OBJS_TCOP:=	   $(SRCS_TCOP:%.c=$(objdir)/%.o)
OBJS_UTILS:=	   $(SRCS_UTILS:%.c=$(objdir)/%.o)

ACCESS.o:	$(OBJS_ACCESS)
	$(make_partial)
BOOTSTRAP.o:	$(OBJS_BOOTSTRAP)
	$(make_partial)
COMMANDS.o:	$(OBJS_COMMANDS)
	$(make_partial)
EXECUTOR.o:	$(OBJS_EXECUTOR)
	$(make_partial)
MAIN.o:		$(OBJS_MAIN) $(OBJS_POSTMASTER)
	$(make_partial)
MISC.o:		$(OBJS_CATALOG) $(OBJS_LIB) $(OBJS_LIBPQ) $(OBJS_PORT)
	$(make_partial)
NODES.o:	$(OBJS_NODES)
	$(make_partial)
PARSER.o:	$(OBJS_PARSER)
	$(make_partial)
OPTIMIZER.o:	$(OBJS_OPTIMIZER)
	$(make_partial)
REGEX.o:	$(OBJS_REGEX)
	$(make_partial)
REWRITE.o:	$(OBJS_REWRITE)
	$(make_partial)
STORAGE.o:	$(OBJS_STORAGE)
	$(make_partial)
TCOP.o:		$(OBJS_TCOP)
	$(make_partial)
UTILS.o:	$(OBJS_UTILS)
	$(make_partial)
endif

#############################################################################
#
# Installation.
#
# Install the bki files to the data directory.  We also copy a version
# of them that has "PGUID" intact, so one can change the value of the
# postgres userid before running initdb in the case of customizing the
# binary release (i.e., fixing up PGUID w/o recompiling the system).
# Those files are copied out as foo.source.  The program newbki(1) can
# be run later to reset the postgres login id (but it must be run before
# initdb is run, or after clearing the data directory with
# cleardbdir(1)). [newbki distributed with v4r2 but not with Postgres95.]
#

# 	NAMEDATALEN=`egrep "^#define NAMEDATALEN" $(CURDIR)/include/postgres.h | awk '{print $$3}'`; \
# 	OIDNAMELEN=`egrep "^#define OIDNAMELEN" $(CURDIR)/include/postgres.h | awk '{print $$3}'`; \

install: beforeinstall pg_id $(BKIFILES) postgres
	$(INSTALL) $(INSTL_EXE_OPTS) $(objdir)/postgres $(DESTDIR)$(BINDIR)/postgres
	@rm -f $(DESTDIR)$(BINDIR)/postmaster
	cd $(DESTDIR)$(BINDIR); ln -s postgres postmaster || cp postgres postmaster
	@cd $(objdir); \
	PG_UID=`./pg_id $(POSTGRESLOGIN)`; \
	POSTGRESLOGIN=$(POSTGRESLOGIN);\
 	echo "NAMEDATALEN = $(NAMEDATALEN)"; \
 	echo "OIDNAMELEN = $(OIDNAMELEN)"; \
	case $$PG_UID in "NOUSER") \
		echo "Warning: no account named $(POSTGRESLOGIN), using yours";\
		POSTGRESLOGIN=`whoami`; \
		PG_UID=`./pg_id`;; \
	esac ;\
	for bki in $(BKIFILES); do \
		sed \
		    -e "s/postgres PGUID/$$POSTGRESLOGIN $$PG_UID/" \
		    -e "s/NAMEDATALEN/$(NAMEDATALEN)/g" \
		    -e "s/OIDNAMELEN/$(OIDNAMELEN)/g" \
		    -e "s/PGUID/$$PG_UID/" \
		    < $$bki > $$bki.sed ; \
		echo "Installing $(DESTDIR)$(DATADIR)/files/$$bki."; \
		$(INSTALL) $(INSTLOPTS) \
		    $$bki.sed $(DESTDIR)$(DATADIR)/files/$$bki; \
		rm -f $$bki.sed; \
		echo "Installing $(DESTDIR)$(DATADIR)/files/$$bki.source."; \
		$(INSTALL) $(INSTLOPTS) \
		    $$bki $(DESTDIR)$(DATADIR)/files/$$bki.source; \
	done;
	@echo "Installing $(DATADIR)/pg_hba";
	@cp $(srcdir)/libpq/pg_hba $(DATADIR)
	@chmod 644 $(DATADIR)/pg_hba


# so we can get the UID of the postgres owner (w/o moving pg_id to
# src/tools). We just want the vanilla LDFLAGS for pg_id
IDLDFLAGS:= $(LDFLAGS)
ifeq ($(PORTNAME), hpux)
ifeq ($(CC), cc)
IDLDFLAGS+= -Aa -D_HPUX_SOURCE
endif
endif
pg_id:	$(srcdir)/bin/pg_id/pg_id.c
	$(CC) $(IDLDFLAGS) -o $(objdir)/$(@F) $<

CLEANFILES+= pg_id postgres


#############################################################################
#
# Support for code development.
#

#
# Build the file, "./ID", used by the "gid" (grep-for-identifier) tool
#
IDFILE=	ID
.PHONY: $(IDFILE)
$(IDFILE):
	$(CURDIR)/makeID $(PORTNAME)

#
# Special rule to generate cpp'd version of a .c file.  This is
# especially useful given all the hellish macro processing going on.
# The cpp'd version has a .C suffix.  To create foo.C from foo.c, just
# type
#	bmake foo.C
#
%.cpp:	%.c
	$(CC) -E $(CFLAGS) $(<:.C=.c) | cat -s | cb | tr -s '\012*' '\012' > $(objdir)/$(@F)

cppall: $(SRCS:.c=.cpp)

#
# To use Purify (SunOS only), define PURIFY to be the path (and
# options) with which to invoke the Purify loader.  Only the executable
# needs to be loaded with Purify.
#
# PURIFY = /usr/sww/bin/purify -cache-dir=/usr/local/postgres/src/backend/purify-cache
#.if defined(PURIFY)
#${PROG}: $(POSTGRES_DEPEND) $(OBJS) $(EXPORTS)
#	${PURIFY} ${CC} ${LDFLAGS} -o $(objdir)/$(@F) $(addprefix $(objdir)/,$(notdir $(OBJS))) $(LDADD)
#
#CLEANFILES+= .purify* .pure .lock.*.o *_pure_*.o *.pure_*link*
#.endif

