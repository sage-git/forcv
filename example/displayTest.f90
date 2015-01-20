program displayTest
   use forCV_core
   use forCV_types
   use forCV_highgui
   implicit none
   type(IplImage),pointer :: image
   type(c_ptr) :: p
   character,pointer :: array(:)
   integer :: ret
   integer :: i,j,k
   double precision :: x,y
   integer,parameter :: Width = 400
   integer,parameter :: Height = 200
   double precision,parameter :: half = dble(Height)/2.d0
   double precision,parameter :: dx = 3.1415926/dble(400)
   character(kind=c_char,len=16) :: windowName
   p = cvCreateImage(CvSize(Width,Height),IPL_DEPTH_8U,3) 
   call c_f_pointer(p,image)
   call c_f_pointer(image%imageData,array,(/image%widthStep*image%height/))
   do i = 1,Height
      do j = 1,Width
         k = (i - 1)*image%widthStep + (j - 1)*3 + 1
         array(k) = achar(0)
         array(k + 1) = achar(0)
         array(k + 2) = achar(0)
      enddo
   enddo 
   do i = 1,Width
      x = dble(i - 1)*dx
      y = half*sin(x)/3.0 + half
      k = int(y)*image%widthStep + (i - 1)*3 + 1
      array(k) = achar(200)
      y = half*cos(x)/3.0 + half
      k = int(y)*image%widthStep + (i - 1)*3 + 1
      array(k + 1) = achar(200)
      y = half*sin(x)/6.0 + half
      k = int(y)*image%widthStep + (i - 1)*3 + 1
      array(k + 2) = achar(200)
   enddo
   windowName = "Sine Waves"//C_NULL_CHAR
   !call cvNamedWindow(windowName,CV_WINDOW_AUTOSIZE)
   call cvShowImage(windowName, c_loc(image))
   ret = cvWaitKey(0)
   call cvDestroyWindow(windowName)
   call cvReleaseImage(c_loc(image))
   stop
end program displayTest
