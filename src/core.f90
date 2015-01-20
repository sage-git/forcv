module forCV_core
   use iso_c_binding
   use forCV_types
   implicit none
   interface
      subroutine cvCreateData(arr) bind(C,name="cvCreateData")
         use iso_c_binding
         type(c_ptr),value :: arr
      end subroutine cvCreateData
      subroutine cvReleaseData(arr) bind(C,name="cvReleaseData")
         use iso_c_binding
         type(c_ptr),value :: arr
      end subroutine cvReleaseData
      function cvCreateImage(size, depth, channels) bind(C,name="cvCreateImage")
         use iso_c_binding
         use forCV_types
         type(CvSize),value :: size
         integer(c_int),value :: depth
         integer(c_int),value :: channels
         type(c_ptr) :: cvCreateImage
      end function cvCreateImage
      subroutine cvReleaseImage(image) bind(C,name="cvReleaseImage") 
         use iso_c_binding
         type(c_ptr) :: image
      end subroutine cvReleaseImage
   end interface

end module forCV_core
