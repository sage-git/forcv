program iotest
   use forCV_core
   use forCV_types
   use forCV_highgui
   implicit none
   type(IplImage),pointer :: image
   type(c_ptr) :: p
   integer :: ret
   character(kind=c_char,len=30) :: filename
   write(*,*)"Input filename of png image"
   read(*,*)filename
   filename = trim(filename)//C_NULL_CHAR
   
   p = cvLoadImage(filename,ior(CV_LOAD_IMAGE_ANYDEPTH,CV_LOAD_IMAGE_ANYCOLOR)) 
   call c_f_pointer(p,image)
   ret = cvSaveImage("output.jpg",c_loc(image),0)
   call cvReleaseImage(c_loc(image))
   stop
end program iotest
