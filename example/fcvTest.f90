program fcvTest
   use forcv
   implicit none
   type(fcvImage) :: image
   integer :: i,j
   type(pixelData) :: v
   integer,parameter :: width = 420
   integer,parameter :: height = 210
  
   call fcvCreateImage(image,width,height)
   do i = 1,height
      do j = 1,width
         v%r = 0
         v%g = 0
         v%b = 0
         if(abs((i - 105)**2 + (j - 210)**2 - 100**2) < 100) v%r = 255
         if(abs((i - 105)**2 + (j - 210)**2 - 90**2) < 100) v%g = 255
         if(abs((i - 105)**2 + (j - 200)**2 - 80**2) < 100) v%b = 255
         v%alpha = 0
         call setPixelAt(image,i,j,v)
      enddo
   enddo
   call fcvShowImage("Circles", image)
   i = fcvWaitKey(10000)
   call fcvDestroyWindow("Circles")
   i = fcvSaveImage(image,"Circles.png")
   call fcvReleaseImage(image)

end program fcvTest
