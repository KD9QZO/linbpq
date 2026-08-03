/**
 * \file bpqaprs.h
 * \brief Definitions for APRS on BPQ
 */

#ifndef BPQAPRS_H_
#define BPQAPRS_H_


/**
 * \defgroup bpq_aprs APRS
 *
 * @{
 */


#define OurSetItemText(hwndLV, i, iSubItem_, pszText_)																\
		{ LV_ITEM _ms_lvi;																							\
			_ms_lvi.iSubItem = iSubItem_;																			\
			_ms_lvi.pszText = pszText_;																				\
			SNDMSG((hwndLV), LVM_SETITEMTEXT, (WPARAM)i, (LPARAM)(LV_ITEM FAR*)&_ms_lvi);							\
		}

#define TRACKPOINTS 100


struct SORTLIST {
	char Callsign[12];
	struct STATIONRECORD *Rec;
} SortList;

/**
 * \brief Structure defining the record of an APRS station
 */
struct STATIONRECORD {
	struct STATIONRECORD *Next;
	char Callsign[12];				/*!< The callsign of the APRS station */
	char Path[120];
	char Status[256];
	char LastPacket[392];			// Was 400. 8 bytes used for Approx Location Flag and Qt Icon pointer
	char Approx;
	char spare1;
	char spare2;
	char spare3;
	void *image;					// used in QtBPQAPRS 
	char LastWXPacket[256];
	int LastPort;
	double Lat;						/*!< The latitude of the APRS station */
	double Lon;						/*!< The longitude of the APRS station */
	double Course;					/*!< The course of the APRS station */
	double Speed;					/*!< The speed of the APRS station */
	double Heading;					/*!< The heading of the APRS station */
	double LatIncr;
	double LongIncr;
	double LastCourse;
	double LastSpeed;
	double Distance;				/*!< The distance to the APRS station */
	double Bearing;					/*!< The bearing (direction) to the APRS station */
	double LatTrack[TRACKPOINTS];	// Cyclic Tracklog
	double LonTrack[TRACKPOINTS];
	time_t TrackTime[TRACKPOINTS];
	int Trackptr;					// Next record in Tracklog
	BOOL Moved;						// Moved since last drawn
	time_t TimeAdded;
	time_t TimeLastUpdated;
	UCHAR Symbol;
	int iconRow;
	int iconCol;					// Symbol Pointer
	char IconOverlay;
	int DispX;						// Position in display buffer
	int DispY;
	int Index;						// List Box Index
	BOOL NoTracks;					// Suppress displaying track
	COLORREF TrackColour;
	char ObjState;					// Live/Killed flag. If zero, not an object
	char LastRXSeq[6];				// Seq from last received message (used for Reply-Ack system)
	BOOL SimpleNumericSeq;			// Station treats seq as a number, not a text field
	struct STATIONRECORD * Object;	// Set if last record from station was an object
	time_t TimeLastTracked;			// Time of last trackpoint
	int NextSeq;
} StationRecord;

typedef struct _APRSHEARDRECORD {
	UCHAR MHCALL[10];				// Stored with space padding
	time_t MHTIME;					// Time last heard
 	time_t LASTMSG;					// Time last message sent from this station (via IS)
	int rfPort;						// RF Port last heard on
	int heardViaIS;					
	BOOL IGate;						// Set if station is an IGate;
//	BYTE MHDIGI[56];				// Not sure if we need this
	struct STATIONRECORD *Station;	// Info previously held by APRS Application
} APRSHEARDRECORD, *PAPRSHEARDRECORD;

struct OSMQUEUE {
	struct OSMQUEUE *Next;
	int Zoom;
	int x;
	int y;
};

/*! \brief Structure defining an APRS message */
struct APRSMESSAGE {
	struct APRSMESSAGE *Next;
	struct STATIONRECORD *ToStation;	// Set on messages we send
	char FromCall[12];					/*!< The callsign of the APRS station that sent the message */
	char ToCall[12];					/*!< The callsign of the APRS station that is to receive the message */
	char Text[104];						/*!< The text of the message */
	char Seq[8];
	BOOL Acked;							/*!< Whether the message has been acknowledged (or not) */
	int Retries;
	int RetryTimer;
	int Port;
	char Time[6];
	BOOL Cancelled;
};

struct APRSConnectionInfo {			// Used for Web Server for thread-specific stuff
	struct STATIONRECORD *SelCall;	// Station Record for individual station display
	HANDLE hPipe;
	SOCKET sock;
	char Callsign[12];
	int WindDirn;					/*!< Wind Direction */
	int WindSpeed;					/*!< Wind Speed */
	int WindGust;					/*!< Wind Gusts */
	int Temp;						/*!< Temperature */
	int RainLastHour;				/*!< Rain in the last hour */
	int RainLastDay;				/*!< Rain in the last day */
	int RainToday;					/*!< Rain today */
	int Humidity;					/*!< Relative Humidity */
	int Pressure;					/*!< Barometric Pressure */
};

// This defines the layout of the first few bytes of shared memory to simplify access from both node and GUI application

/**
 * \brief Shared memory layout, simplifying access from both the node and the GUI application
 *
 * This defines the layout of the first few bytes of shared memory to simplify access from both the node and the GUI
 * application.
 *
 * \note This is a maximum of <b>32 bytes</b> unless the code is changed.
 * \attention Don't change existing items without changing \p Version and clients.
 */
struct SharedMem {
	UCHAR Version;				// For compatibility check
	UCHAR NeedRefresh;			// Messages Have Changed
	UCHAR ClearRX;
	UCHAR ClearTX;
	int SharedMemLen;						/*!< The length of the shared memory, so the client knows the size to map */		// So Client knows size to map
	struct APRSMESSAGE *Messages;			/*!< Pointer to the APRS messages */
	struct APRSMESSAGE *OutstandingMsgs;	/*!< Pointer to the outstanding APRS messages */
	int Arch;					 			/*!< Used to detect whether we are running on a 64 bit system */					// to detect running on 64 bit system.
#pragma pack(1)
	UCHAR SubVersion;
#pragma pack()
};


#define BPQBASE			WM_USER

//
//	Port monitoring flags use BPQBASE -> BPQBASE + 16

#define BPQMTX			(BPQBASE + 40)
#define BPQMCOM			(BPQBASE + 41)
//#define BPQCOPY		(BPQBASE + 42)


#define APRSSHAREDMEMORYBASE 0x43000000		// Base of shared memory segment


#if (!defined(MAXSTATIONS) || defined(__DOXYGEN__))
/**
 * \brief Defines the maximum number of APRS stations
 *
 * \note The default is \b 5000
 */
#define MAXSTATIONS 5000
#endif

#if (!defined(MAXMESSAGES) || defined(__DOXYGEN__))
/**
 * \brief Defines the maximum number of APRS messages
 *
 * \note The default is \b 1000
 */
#define MAXMESSAGES 1000
#endif

/**
 * @}
 */

#endif	/* !BPQAPRS_H_ */

