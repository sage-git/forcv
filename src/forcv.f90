module forcv
   use iso_c_binding
   use forcv_types
   use forcv_core
   use forcv_highgui

   implicit none
!----------------------------
!    Opencv wrapper struct
!----------------------------
   type fcvImage
      type(IplImage),pointer :: image
      character(c_char),pointer :: imageData(:)
      type(c_ptr) :: imagePtr
   end type

!-----------------------------
!     fcv original struct
!-----------------------------
   type pixelData
      integer :: r,g,b,alpha
   end type
contains
!---------------------------
!  forcv wrapper functions
!---------------------------
   subroutine fcvCreateImage(self,width,height,depth,channel)
       type(fcvImage) :: self
       integer,intent(in) :: width,height
       integer,intent(in),optional :: depth,channel
       integer(c_int) :: ndepth,nchannel
       integer :: nPixel
       ndepth = IPL_DEPTH_8U
       if(present(depth)) ndepth = depth
       nchannel = 3
       if(present(channel)) nchannel = channel
       self%imagePtr = cvCreateImage(CvSize(width,height),ndepth,nchannel)
       call c_f_pointer(self%imagePtr,self%image)
       nPixel = self%image%imageSize
       call c_f_pointer(self%image%imageData,self%imageData,(/nPixel/))
   end subroutine fcvCreateImage

   subroutine fcvLoadImage(self,filename,switch)
       type(fcvImage) :: self
       character(len=*) :: filename
       integer,optional,intent(in) :: switch
       integer(c_int) :: opt
       integer :: nPixel
       opt = ior(CV_LOAD_IMAGE_ANYDEPTH,CV_LOAD_IMAGE_ANYCOLOR)
       if(present(switch)) opt = switch
       self%imagePtr = cvLoadImage(trim(filename)//C_NULL_CHAR,opt)
       call c_f_pointer(self%imagePtr,self%image)
       nPixel = self%image%imageSize
       call c_f_pointer(self%image%imageData,self%imageData,(/nPixel/))
   end subroutine fcvLoadImage

   function fcvSaveImage(self,filename,switch) result(r)
       type(fcvImage) :: self
       character(len=*) :: filename
       integer,optional,intent(in) :: switch
       integer :: r
       integer(c_int) :: opt
       opt = 0
       if(present(switch)) opt = switch 
       r = cvSaveImage(trim(filename)//C_NULL_CHAR,c_loc(self%image),opt)
   end function fcvSaveImage

   subroutine fcvReleaseImage(self)
       type(fcvImage) :: self
       call cvReleaseImage(c_loc(self%image))
       nullify(self%image)
       nullify(self%imageData)
   end subroutine fcvReleaseImage


   subroutine fcvNamedWindow(windowName,switch)
       character(len=*) :: windowName
       integer,intent(in),optional :: switch
       integer(c_int) :: opt
       opt = CV_WINDOW_AUTOSIZE
       if(present(switch)) opt = switch
       call cvNamedWindow(trim(windowName)//C_NULL_CHAR, opt)
   end subroutine fcvNamedWindow
   subroutine fcvShowImage(windowName, image)
       character(len=*) :: windowName
       type(fcvImage) :: image
       call cvShowImage( trim(windowName)//C_NULL_CHAR,image%imagePtr)
   end subroutine fcvShowImage
   function fcvWaitKey(delay)
      integer,intent(in) :: delay
      integer :: fcvWaitKey
      integer(c_int)   :: d
      d = delay
      fcvWaitKey = cvWaitKey(d) 
   end function fcvWaitKey
   subroutine fcvDestroyWindow(windowName)
       character(len=*) :: windowName
       call cvDestroyWindow(trim(windowName)//C_NULL_CHAR)
   end subroutine fcvDestroyWindow
!--------------------------
!  fcv original functions
!--------------------------
   function getPixelAt(self,row,col) result(ret)
      type(fcvImage),intent(in) :: self
      integer,intent(in) :: row,col
      type(pixelData) :: ret
      character(c_char) :: r,g,b,alpha
      integer :: p,w,h,ws,nc
      w = self%image%width
      h = self%image%height
      ws = self%image%widthStep
      nc = self%image%nChannels
      if((row < 1 .or. row > h) .or. &
     &    (col < 1 .or. col > w))then
         ret = pixelData(0,0,0,0)
         return
      endif
      b = c_null_char
      g = c_null_char
      r = c_null_char
      alpha = c_null_char
      p = (row - 1)*ws + (col - 1)*nc
      b = self%imageData(p + 1)
      if(nc == 2) g = self%imageData(p + 2)
      if(nc == 3) r = self%imageData(p + 3)
      ret = pixelData(iachar(r),iachar(g),iachar(b),iachar(alpha))
   end function getPixelAt
   
   subroutine setPixelAt(self,row,col,val)
      type(fcvImage) :: self
      integer,intent(in) :: row,col
      type(pixelData),intent(in) :: val
      integer :: p,w,h,ws,nc
      integer :: b,g,r,alpha
      w = self%image%width
      h = self%image%height
      ws = self%image%widthStep
      nc = self%image%nChannels
      if((row < 1 .or. row > h) .or. &
     &    (col < 1 .or. col > w))then
         return
      endif
      p = (row - 1)*ws + (col - 1)*nc
      b = min(max(0,val%b),255)
      g = min(max(0,val%g),255)
      r = min(max(0,val%r),255)
      self%imageData(p + 1) = achar(b)
      if(nc == 1) return
      self%imageData(p + 2) = achar(g)
      if(nc == 2) return
      self%imageData(p + 3) = achar(r)
   end subroutine setPixelAt
end module forcv
