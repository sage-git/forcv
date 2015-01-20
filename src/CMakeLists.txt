add_library(forcv_core core.f90 types.f90)
add_library(forcv_highgui highgui.f90 core.f90 types.f90)

set(modfiles
 ${PROJECT_BINARY_DIR}/src/forcv_core.mod
 ${PROJECT_BINARY_DIR}/src/forcv_highgui.mod
 ${PROJECT_BINARY_DIR}/src/forcv_types.mod
)
install(
  TARGETS forcv_core forcv_highgui
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)
install(FILES ${modfiles} DESTINATION include)
