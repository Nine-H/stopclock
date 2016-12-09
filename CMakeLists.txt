# project name
project (stopclock)

# the oldest stable cmake verison we support
cmake_minimum_required (VERSION 2.6)

# tell cmake where its modules can be found in our project
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# where we install data directory (if we have any)
set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

# what to call that directory where we install data to
set (PKGDATADIR "${DATADIR}/stopclock")

# what to call that directory where we install data to
set (PKGDATADIR "${DATADIR}/stopclock")

set (EXEC_NAME "stopclock")
set (RELEASE_NAME "A timer utility")
set (VERSION "0.1")
set (VERSION_INFO "whats up world")

# we're about to use pkgconfig to make sure dependencies are installed
find_package(PkgConfig)

# now let's actually check for the required dependencies
pkg_check_modules(DEPS REQUIRED gtk+-3.0
    granite
)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES} -lm)
link_directories(${DEPS_LIBRARY_DIRS})

# make sure we have vala
find_package(Vala REQUIRED)
# make sure we use vala
include(ValaVersion)
# make sure it's the desired version of vala
#ensure_vala_version("0.29.1" MINIMUM)

# files we want to compile
include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/countdown.vala
    src/utils.vala
    src/worldclock.vala
    src/alarm.vala
    src/eggtimer.vala
    src/reminder.vala
    src/stopwatch.vala
    src/window.vala
    src/stopclock.vala

# tell what libraries to use when compiling
PACKAGES
    granite
    gtk+-3.0
    glib-2.0>=2.32
    libnotify
)

# tell cmake what to call the executable we just made
add_executable(${EXEC_NAME} ${VALA_C})

# install the binaries we just made
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

# install our .desktop file so the Applications menu will see it
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/stopclock.desktop DESTINATION ${DATADIR}/applications/)

# install stopwatch icon from sysprof so this shit fucking works
#install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/stopwatch-symbolic.svg DESTINATION ${DATADIR}/stopclock)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/stopclock-symbolic.svg DESTINATION ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/scalable/actions )
