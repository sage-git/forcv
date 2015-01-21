add_library(forcv_types types.f90)
add_library(forcv_core core.f90)
add_library(forcv_highgui highgui.f90)
set(modfiles
 ${PROJECT_BINARY_DIR}/src/forcv_core.mod
 ${PROJECT_BINARY_DIR}/src/forcv_highgui.mod
 ${PROJECT_BINARY_DIR}/src/forcv_types.mod
)

if(forcvMod)
  add_library(forcv forcv.f90 highgui.f90 core.f90 types.f90)
  set(modfiles ${modfiles} ${PROJECT_BINARY_DIR}/src/forcv.mod)
endif()

install(
  TARGETS forcv_core forcv_highgui forcv_types
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)
if(forcvMod)
  install(
    TARGETS forcv
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
  )
endif()
install(FILES ${modfiles} DESTINATION include)
