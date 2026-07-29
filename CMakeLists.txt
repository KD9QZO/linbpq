CMAKE_MINIMUM_REQUIRED(VERSION 3.5)
PROJECT(linbpq C)

#ADD_COMPILE_OPTIONS(-Ofast -march=native)

SET(LINBPQ_SRC_FILES
		pngwtran.c
		pngrtran.c
		pngset.c
		pngrio.c
		pngwio.c
		pngtrans.c
		pngrutil.c
		pngwutil.c
		pngread.c
		pngwrite.c
		png.c
		pngerror.c
		pngget.c
		pngmem.c
		APRSIconData.c
		AISCommon.c
		upnp.c
		APRSStdPages.c
		HSMODEM.c
		WinRPR.c
		KISSHF.c
		TNCEmulators.c
		bpqhdlc.c
		SerialPort.c
		adif.c
		WebMail.c
		utf8Routines.c
		VARA.c
		LzFind.c
		Alloc.c
		LzmaDec.c
		LzmaEnc.c
		LzmaLib.c
		Multicast.c
		ARDOP.c
		IPCode.c
		FLDigi.c
		linether.c
		CMSAuth.c
		APRSCode.c
		BPQtoAGW.c
		KAMPactor.c
		AEAPactor.c
		HALDriver.c
		MULTIPSK.c
		BBSHTMLConfig.c
		ChatHTMLConfig.c
		BBSUtilities.c
		bpqaxip.c
		BPQINP3.c
		BPQNRR.c
		cMain.c
		Cmd.c
		CommonCode.c
		HTMLCommonCode.c
		compatbits.c
		config.c
		datadefs.c
		FBBRoutines.c
		HFCommon.c
		Housekeeping.c
		HTTPcode.c
		kiss.c
		L2Code.c
		L3Code.c
		L4Code.c
		lzhuf32.c
		MailCommands.c
		MailDataDefs.c
		LinBPQ.c
		MailRouting.c
		MailTCP.c
		MBLRoutines.c
		md5.c
		Moncode.c
		NNTPRoutines.c
		RigControl.c
		TelnetV6.c
		WINMOR.c
		TNCCode.c
		UZ7HODrv.c
		WPRoutines.c
		SCSTrackeMulti.c
		SCSPactor.c
		SCSTracker.c
		HanksRT.c
		UIRoutines.c
		AGWAPI.c
		AGWMoncode.c
		DRATS.c
		FreeDATA.c
		base64.c
		Events.c
		nodeapi.c
		mailapi.c
		mqtt.c
		RHP.c
		NETROMTCP.c
)

SET(XAPRS_SRC_FILES
		XAprs.c
)

ADD_EXECUTABLE(linbpq ${LINBPQ_SRC_FILES})
ADD_EXECUTABLE(XAprs ${XAPRS_SRC_FILES})


TARGET_COMPILE_DEFINITIONS(linbpq PRIVATE
		LINBPQ
)

TARGET_COMPILE_OPTIONS(linbpq PRIVATE
		"-Wall"
		"-fcommon"
		"-fasynchronous-unwind-tables"
)


FIND_PACKAGE(PkgConfig)
IF (PKG_CONFIG_FOUND)
	PKG_CHECK_MODULES(LIBGTK2 gtk+-2.0)
	IF (LIBGTK2_FOUND)
		MESSAGE(STATUS "Using libgtk+-2.0")
#		ADD_DEFINITIONS(-DHAVE_LIBACARS)
		TARGET_LINK_LIBRARIES(XAprs ${LIBGTK2_LIBRARIES})
		TARGET_INCLUDE_DIRECTORIES(XAprs PUBLIC ${LIBGTK2_INCLUDE_DIRS})
		LINK_DIRECTORIES(${LIBGTK2_LIBRARY_DIRS})
	ELSE ()
		MESSAGE(STATUS "libgtk+-2.0 not found -- unable to build XAprs")
	ENDIF ()
ENDIF ()


########################################################################################################################
# MQTT Support
########################################################################################################################

OPTION(USE_MQTT "Compile with MQTT support" ON)
IF (USE_MQTT)
	MESSAGE(STATUS "Attempting to build with MQTT support")
	FIND_LIBRARY(MQTT paho-mqtt3a)
	IF (NOT MQTT)
		MESSAGE(FATAL_ERROR "paho-mqtt3a path not found, cannot build with MQTT support")
	ENDIF ()
	TARGET_LINK_LIBRARIES(linbpq ${MQTT} jansson)
ELSE ()
	MESSAGE(STATUS "Excluding MQTT support from build")
	TARGET_COMPILE_DEFINITIONS(linbpq PRIVATE
			NOMQTT
	)
ENDIF ()

########################################################################################################################
# I2C Support
########################################################################################################################

OPTION(USE_I2C "Compile with I2C support" OFF)
IF (USE_I2C)
	MESSAGE(STATUS "Attempting to build with I2C support")
ELSE ()
	MESSAGE(STATUS "Excluding I2C support from build")
	TARGET_COMPILE_DEFINITIONS(linbpq PRIVATE
			NOI2C
	)
ENDIF ()

#OPTION(LTO "Compile and Link with Link-Time Optimization")
#IF (LTO)
#	ADD_DEFINITIONS(-DWITH_SOAPY)
#	TARGET_SOURCES(acarsdec PRIVATE soapy.c)
#	TARGET_LINK_LIBRARIES(acarsdec ${LIBSOAPY})
#ENDIF ()


TARGET_LINK_LIBRARIES(linbpq pthread m rt z config pcap miniupnpc)
TARGET_LINK_LIBRARIES(XAprs jpeg X11 m rt config png)

INSTALL(
		TARGETS linbpq XAprs
		RUNTIME DESTINATION bin
)

