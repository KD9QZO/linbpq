#
# FindMiniUPNPC.cmake
#

find_path(MINIUPNPC_INCLUDE_DIR miniupnpc.h HINTS /usr/include /usr/local/include /usr/include/miniupnpc /usr/local/include/miniupnpc)

find_library(MINIUPNPC_LIBRARY NAMES miniupnpc HINTS /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(MiniUPNPC DEFAULT_MSG MINIUPNPC_INCLUDE_DIR MINIUPNPC_LIBRARY)

