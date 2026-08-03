#
# LinBPQ Makefile
#
# ======================================================================================================================
# To exclude i2c support run make noi2c
# ======================================================================================================================

OUTFILE := linbpq

OBJS := \
		pngwtran.o \
		pngrtran.o \
		pngset.o \
		pngrio.o \
		pngwio.o \
		pngtrans.o \
		pngrutil.o \
		pngwutil.o \
		pngread.o \
		pngwrite.o \
		png.o \
		pngerror.o \
		pngget.o \
		pngmem.o \
		APRSIconData.o \
		AISCommon.o \
		upnp.o \
		APRSStdPages.o \
		HSMODEM.o \
		WinRPR.o \
		KISSHF.o \
		TNCEmulators.o \
		bpqhdlc.o \
		SerialPort.o \
		adif.o \
		WebMail.o \
		utf8Routines.o \
		VARA.o \
		LzFind.o \
		Alloc.o \
		LzmaDec.o \
		LzmaEnc.o \
		LzmaLib.o \
		Multicast.o \
		ARDOP.o \
		IPCode.o \
		FLDigi.o \
		linether.o \
		CMSAuth.o \
		APRSCode.o \
		BPQtoAGW.o \
		KAMPactor.o \
		AEAPactor.o \
		HALDriver.o \
		MULTIPSK.o \
		BBSHTMLConfig.o \
		ChatHTMLConfig.o \
		BBSUtilities.o \
		bpqaxip.o \
		BPQINP3.o \
		BPQNRR.o \
		cMain.o \
		Cmd.o \
		CommonCode.o \
		HTMLCommonCode.o \
		compatbits.o \
		config.o \
		datadefs.o \
		FBBRoutines.o \
		HFCommon.o \
		Housekeeping.o \
		HTTPcode.o \
		kiss.o \
		L2Code.o \
		L3Code.o \
		L4Code.o \
		lzhuf32.o \
		MailCommands.o \
		MailDataDefs.o \
		LinBPQ.o \
		MailRouting.o \
		MailTCP.o \
		MBLRoutines.o \
		md5.o \
		Moncode.o \
		NNTPRoutines.o \
		RigControl.o \
		TelnetV6.o \
		WINMOR.o \
		TNCCode.o \
		UZ7HODrv.o \
		WPRoutines.o \
		SCSTrackeMulti.o \
		SCSPactor.o \
		SCSTracker.o \
		HanksRT.o \
		UIRoutines.o \
		AGWAPI.o \
		AGWMoncode.o \
		DRATS.o \
		FreeDATA.o \
		base64.o \
		Events.o \
		nodeapi.o \
		mailapi.o \
		mqtt.o \
		RHP.o \
		NETROMTCP.o

# ======================================================================================================================
# Configuration:
#
# Default to Linux
# ======================================================================================================================

CC  ?= gcc
CXX ?= g++


CSTD   ?= gnu11
CXXSTD ?= gnu++14
OPTLVL ?= 2
DBGLVL ?= 0


DEFINES := -DLINBPQ

SHARED_CFLAGS := -Wall -MMD -std=$(CSTD) -O$(OPTLVL) -g$(DBGLVL) -fcommon -fasynchronous-unwind-tables

MAPFILE := linbpq.map

LINUX_LIBS := -lrt

LDFLAGS := -Xlinker -Map=$(MAPFILE) $(LINUX_LIBS)

all: CFLAGS = $(SHARED_CFLAGS)
all: LIBS = -lpaho-mqtt3a -ljansson -lminiupnpc -lm -lz -lpthread -lconfig -lpcap
all: linbpq


# ======================================================================================================================
# other OS
# ======================================================================================================================

OS_NAME = $(shell uname -s)

ifeq ($(OS_NAME),NetBSD)
CC  ?= cc
CXX ?= cxx

CSTD ?= c99

DEFINES += -DFREEBSD
DEFINES += -DNOMQTT

EXTRA_CFLAGS  := -I/usr/pkg/include
LDFLAGS       := -Xlinker -Map=$(MAPFILE) -Wl,-R/usr/pkg/lib -L/usr/pkg/lib -lrt -lutil -lexecinfo
SHARED_CFLAGS := -Wall -MMD -std=$(CSTD) -O$(OPTLVL) -g$(DBGLVL) -fcommon -fasynchronous-unwind-tables

all: CFLAGS := $(SHARED_CFLAGS) $(EXTRA_CFLAGS) $(DEFINES)
all: LIBS   := -lminiupnpc -lm -lz -lpthread -lconfig -lpcap
all: linbpq
endif

# ----------------------------------------------------------------------------------------------------------------------

ifeq ($(OS_NAME),FreeBSD)
CC  ?= cc
CXX ?= cxx

CSTD ?= c99

DEFINES += -DFREEBSD
DEFINES += -DNOMQTT

EXTRA_CFLAGS  := -I/usr/local/include
LDFLAGS       := -Xlinker -Map=$(MAPFILE) -L/usr/local/lib -lrt -liconv -lutil -lexecinfo
SHARED_CFLAGS := -Wall -MMD -std=$(CSTD) -O$(OPTLVL) -g$(DBGLVL) -fcommon -fasynchronous-unwind-tables

all: CFLAGS := $(SHARED_CFLAGS) $(EXTRA_CFLAGS) $(DEFINES)
all: LIBS =  -lminiupnpc -lm -lz -lpthread -lconfig -lpcap
all: linbpq
endif

# ----------------------------------------------------------------------------------------------------------------------

ifeq ($(OS_NAME),Darwin)
CC  ?= gcc
CXX ?= g++

CSTD ?= gnu11

DEFINES += -DMACBPQ
DEFINES += -DNOMQTT

EXTRA_CFLAGS  :=
LDFLAGS       := -liconv
SHARED_CFLAGS := -Wall -MMD -std=$(CSTD) -O$(OPTLVL) -g$(DBGLVL) -fcommon -fasynchronous-unwind-tables

all: CFLAGS := $(SHARED_CFLAGS) $(EXTRA_CFLAGS) $(DEFINES)
all: LIBS   := -lminiupnpc -lm -lz -lpthread -lconfig -lpcap
all: linbpq
endif

# ----------------------------------------------------------------------------------------------------------------------

$(info OS_NAME is $(OS_NAME))

# ----------------------------------------------------------------------------------------------------------------------

nomqtt: DEFINES += -DNOMQTT
nomqtt: EXTRA_CFLAGS := -rdynamic
nomqtt: CFLAGS := $(SHARED_CFLAGS) $(EXTRA_CFLAGS) $(DEFINES)
nomqtt: LIBS   := -lminiupnpc -lm -lz -lpthread -lconfig -lpcap
nomqtt: linbpq

noi2c: DEFINES += -DNOI2C
noi2c: EXTRA_CFLAGS := -rdynamic
noi2c: CFLAGS := $(SHARED_CFLAGS) $(EXTRA_CFLAGS) $(DEFINES)
noi2c: LIBS   := -lpaho-mqtt3a -ljansson -lminiupnpc -lm -lz -lpthread -lconfig -lpcap
noi2c: linbpq


$(OUTFILE): $(OBJS)
	$(CC) $(OBJS) $(CFLAGS) $(LDFLAGS) $(LIBS) -o $(OUTFILE)
	sudo setcap "CAP_NET_ADMIN=ep CAP_NET_RAW=ep CAP_NET_BIND_SERVICE=ep" $(OUTFILE)

-include *.d


clean:
	@echo "Cleaning build artifacts..."
	rm -f *.d
	rm -f *.o
	rm -f $(OBJS)
	rm -f $(OUTFILE)

clean-objs-only:
	@echo "Cleaning object files only..."
	rm -f *.d
	rm -f *.o
	rm -f $(OBJS)

