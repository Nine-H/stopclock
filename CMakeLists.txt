project (stopclock)

cmake_minimum_required (VERSION 2.6)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

set (PKGDATADIR "${DATADIR}/stopclock")

set (PKGDATADIR "${DATADIR}/stopclock")

set (EXEC_NAME "stopclock")
set (RELEASE_NAME "A timer utility")
set (VERSION "0.1")
set (VERSION_INFO "out of the labs ;D")

find_package(PkgConfig)

pkg_check_modules(DEPS REQUIRED
    gtk+-3.0
    granite
    libnotify
)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES} -lm)
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.29.1" MINIMUM)

include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/widgets/counter.vala
    src/widgets/hms_popover.vala
    src/widgets/reminder_timer.vala
    src/widgets/eggtimer_timer.vala
    src/utils.vala
    src/manager_view.vala
    src/stopwatch.vala
    src/window.vala
    src/stopclock.vala

PACKAGES
    granite
    gtk+-3.0
    glib-2.0>=2.32
    libnotify
)

add_executable(${EXEC_NAME} ${VALA_C})

install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/stopclock.desktop DESTINATION ${DATADIR}/applications/)

install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/stopclock.css DESTINATION ${DATADIR}/stopclock)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/stopclock-symbolic.svg DESTINATION ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/scalable/actions )

include (GSettings)
add_schema ("data/com.github.nine-h.stopclock.gschema.xml")
