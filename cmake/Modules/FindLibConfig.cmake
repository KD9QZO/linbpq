#
# FindLibConfig.cmake
#

find_path(LIBCONFIG_INCLUDE_DIR libconfig.h HINTS /usr/include /usr/local/include)

find_library(LIBCONFIG_LIBRARY NAMES config HINTS /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(LibConfig DEFAULT_MSG LIBCONFIG_INCLUDE_DIR LIBCONFIG_LIBRARY)

