#
# FindPCAP.cmake
#

find_path(PCAP_INCLUDE_DIR pcap.h HINTS /usr/include /usr/local/include)

find_library(PCAP_LIBRARY NAMES pcap HINTS /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(PCAP DEFAULT_MSG PCAP_INCLUDE_DIR PCAP_LIBRARY)

