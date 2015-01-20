module forCV_highgui
   use forCV_types

   implicit none
   
   enum,bind(C)
      ENUMERATOR :: CV_IMWRITE_JPEG_QUALITY = 1
      ENUMERATOR :: CV_IMWRITE_PNG_COMPRESSION = 16
      ENUMERATOR :: CV_IMWRITE_PNG_STRATEGY = 17
      ENUMERATOR :: CV_IMWRITE_PNG_BILEVEL = 18
      ENUMERATOR :: CV_IMWRITE_PNG_STRATEGY_DEFAULT = 0
      ENUMERATOR :: CV_IMWRITE_PNG_STRATEGY_FILTERED = 1
      ENUMERATOR :: CV_IMWRITE_PNG_STRATEGY_HUFFMAN_ONLY = 2
      ENUMERATOR :: CV_IMWRITE_PNG_STRATEGY_RLE = 3
      ENUMERATOR :: CV_IMWRITE_PNG_STRATEGY_FIXED = 4
      ENUMERATOR :: CV_IMWRITE_PXM_BINARY = 32
   end enum
   enum,bind(C)
      ENUMERATOR :: CV_LOAD_IMAGE_UNCHANGED = -1
      enumerator :: CV_LOAD_IMAGE_GRAYSCALE = 0
      enumerator :: CV_LOAD_IMAGE_COLOR     = 1
      enumerator :: CV_LOAD_IMAGE_ANYDEPTH  = 2
      enumerator :: CV_LOAD_IMAGE_ANYCOLOR  = 4
   end enum
   enum,bind(C)
      enumerator :: CV_WND_PROP_PULLSCREEN  = 0
      enumerator :: CV_WND_PROP_AUTOSIZE    = 1
      enumerator :: CV_WND_PROP_ASPECTRATIO = 2
      enumerator :: CV_WND_PROP_OPENGL      = 3
      enumerator :: CV_WINDOW_NORMAL    = z'00000000'
      enumerator :: CV_WINDOW_AUTOSIZE  = z'00000001'
      enumerator :: CV_WINDOW_OPENGL    = z'00001000'
      enumerator :: CV_GUI_EXPANDED     = z'00000000'
      enumerator :: CV_GUI_NORMAL       = z'00000010'
      enumerator :: CV_WINDOW_FULLSCREEN  = 1
      enumerator :: CV_WINDOW_FREERATIO   = z'00000100'
      enumerator :: CV_WINDOW_KEEPRATIO   = z'00000000' 
   end enum 
   interface
      function cvLoadImage(filename,iscolor)  bind(C,name="cvLoadImage")
         use iso_c_binding
         character(kind=c_char),intent(in) :: filename(*)
         integer(c_int),value :: iscolor
         type(c_ptr) :: cvLoadImage
      end function cvLoadImage
      function cvSaveImage(filename,image,params) bind(C,name="cvSaveImage")
         use iso_c_binding
         character(kind=c_char),intent(in) :: filename(*)
!         type(IplImage),intent(in) :: image
         type(c_ptr),value,intent(in) :: image
         integer(c_int),intent(in) :: params
         integer(c_int) :: cvSaveImage
      end function cvSaveImage

      subroutine cvNamedWindow(name,flags) bind(C,name="cvNamedWindow")
         use iso_c_binding
         character(kind=c_char),intent(in) :: name(*)
         integer(c_int),value :: flags
      end subroutine cvNamedWindow
      subroutine cvShowImage(name,image) bind(C,name="cvShowImage")
         use iso_c_binding
         character(kind=c_char),intent(in) :: name(*)
         type(c_ptr),value,intent(in) :: image
      end subroutine cvShowImage      
      function cvWaitKey(delay) bind(C,name="cvWaitKey")
         use iso_c_binding
         integer(c_int),value :: delay
         integer(c_int) :: cvWaitKey
      end function cvWaitKey
      subroutine cvDestroyWindow(name) bind(C,name="cvDestroyWindow")
         use iso_c_binding
         character(kind=c_char),intent(in) :: name(*)
      end subroutine cvDestroyWindow
   end interface
end module forCV_highgui
