#
# src/CMakeLists.txt
#

INCLUDE(GNUInstallDirs)

MACRO(LINBPQ_APPEND_SRCS)
	LIST(APPEND linbpq_srcs ${ARGV})
ENDMACRO(LINBPQ_APPEND_SRCS)


LINBPQ_APPEND_SRCS(
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
)


########################################################################
# Setup libraries used in executables and build executable
########################################################################

ADD_EXECUTABLE(linbpq ${linbpq_srcs})

SET(INSTALL_TARGETS linbpq)

TARGET_LINK_LIBRARIES(linbpq ${CMAKE_THREAD_LIBS_INIT})


FIND_LIBRARY(LIBRT rt)

IF (LIBRT)
	MESSAGE("Found librt: ${LIBRT}")
	TARGET_LINK_LIBRARIES(linbpq ${LIBRT})
ELSE ()
	MESSAGE(FATAL_ERROR "librt not found")
ENDIF()

TARGET_LINK_LIBRARIES(linbpq m)

if (ZLIB_FOUND)
	MESSAGE("Found libz: ${ZLIB_VERSION}")
	TARGET_LINK_LIBRARIES(linbpq ${ZLIB_LIBRARIES})
else ()
	MESSAGE(FATAL_ERROR "libz not found")
endif ()

TARGET_LINK_LIBRARIES(linbpq ${LIBCONFIG_LIBRARY})
TARGET_LINK_LIBRARIES(linbpq ${PCAP_LIBRARY})
TARGET_LINK_LIBRARIES(linbpq ${MINIUPNPC_LIBRARY})


########################################################################
# Install built executable and other files
########################################################################

INSTALL(TARGETS ${INSTALL_TARGETS}
		LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}		# .so/.dylib file
		ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}		# .lib file
		RUNTIME DESTINATION bin							# .dll file
)

