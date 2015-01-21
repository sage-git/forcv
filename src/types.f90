module forCV_types
   use,intrinsic :: iso_c_binding
   implicit none
   type,bind(C) :: CvMat
     integer(c_int) :: type
     integer(c_int) :: step
     type(c_ptr) :: data
     integer(c_int) :: rows
     integer(c_int) :: cols
   end type
   type,bind(C) :: CvSize
     integer(c_int) :: width
     integer(c_int) :: height
   end type
   type,bind(C) :: IplImage
     integer(c_int) :: nSize
     integer(c_int) :: ID
     integer(c_int) :: nChannels
     integer(c_int) :: alphaChannels
     integer(c_int) :: depth
     character(kind=c_char) :: colorModel(4)
     character(kind=c_char) :: channelSeq(4)
     integer(c_int) :: dataOrder
     integer(c_int) :: origin
     integer(c_int) :: align
     integer(c_int) :: width
     integer(c_int) :: height
     type(C_ptr) :: roi
     type(C_ptr) :: maskROI
     type(C_ptr) :: imageID
     type(C_ptr) :: tileInfo
     integer(c_int) :: imageSize
     type(C_ptr) :: imageData
     integer(c_int) :: widthStep
     integer(c_int) :: BorderMode(4)
     integer(c_int) :: BorderConst(4)
     type(C_ptr) :: imageDataOrigin
   end type
   type,bind(C) :: IplROI
     integer(c_int) :: coi
     integer(c_int) :: xOffset
     integer(c_int) :: yOffset
     integer(c_int) :: width
     integer(c_int) :: height
   end type 


   integer(c_int),parameter :: IPL_DEPTH_1U = 1
   integer(c_int),parameter :: IPL_DEPTH_8U = 8
   integer(c_int),parameter :: IPL_DEPTH_16U = 16
   integer(c_int),parameter :: IPL_DEPTH_32U = 32

   integer(c_int),parameter :: IPL_DATA_ORDER_PIXEL = 0
   integer(c_int),parameter :: IPL_DATA_ORDER_PLANE = 1

   integer(c_int),parameter :: IPL_ORIGIN_TL = 0
   integer(c_int),parameter :: IPL_ORIGIN_BL = 1

   integer(c_int),parameter :: IPL_ALIGN_4BYTES = 4
   integer(c_int),parameter :: IPL_ALIGN_8BYTES = 8
   integer(c_int),parameter :: IPL_ALIGN_16BYTES = 16
   integer(c_int),parameter :: IPL_ALIGN_32BYTES = 32

   integer(c_int),parameter :: IPL_ALIGN_DWORD = IPL_ALIGN_4BYTES
   integer(c_int),parameter :: IPL_ALIGN_QWORD = IPL_ALIGN_8BYTES
   
   integer(c_int),parameter :: IPL_BORDER_CONSTANT = 0
   integer(c_int),parameter :: IPL_BORDER_REPLICATE = 1
   integer(c_int),parameter :: IPL_BORDER_REFLECT = 2
   integer(c_int),parameter :: IPL_BORDER_WRAP = 3
contains
!--------------------------
!  functions defined as macro
!--------------------------
   ! get reference to pixel at (col,row),
   ! for multi-channel images (col) should be multiplied by number of channels
   function CV_IMAGE_ELEM(image, elemtype,row,col)
      type(IplImage),intent(in) :: image
      character(len=*),intent(in) :: elemtype
      integer,intent(in) :: row,col
      type(c_ptr) :: CV_IMAGE_ELEM
      integer(c_intptr_t) :: ptr
      integer(c_intptr_t) :: elemSize
      character(len=32) :: ptrExpr
      elemSize = 1
      write(ptrExpr,*)image%imageData
      read(ptrExpr,*) ptr
      ptr = ptr + elemSize*image%widthStep*row + col 
      write(ptrExpr,*) ptr
      read(ptrExpr,*) CV_IMAGE_ELEM
   end function CV_IMAGE_ELEM
end module forCV_types
