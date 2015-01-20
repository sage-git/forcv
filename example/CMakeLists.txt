#project(forCV examples)
link_directories("${PROJECT_BINARY_DIR}/src") 
link_directories("${OpenCV_LIB_DIR}")
include_directories("${PROJECT_BINARY_DIR}/src")

add_executable(fileIOTest readWrite.f90)
add_executable(displayTest displayTest.f90)

target_link_libraries(fileIOTest libforcv_core.a libforcv_highgui.a ${OpenCV_LIBS})
target_link_libraries(displayTest libforcv_core.a libforcv_highgui.a ${OpenCV_LIBS})

