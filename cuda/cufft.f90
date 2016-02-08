module precision
! Precision control

integer, parameter, public :: Single = kind(0.0) ! Single precision
integer, parameter, public :: Double = kind(0.0d0) ! Double precision

!integer, parameter, public :: fp_kind = Double
integer, parameter, public :: fp_kind = Single

end module precision

!
! Define the INTERFACE to the NVIDIA CUFFT routines
!

module cufft

integer, public :: CUFFT_FORWARD = -1
integer, public :: CUFFT_INVERSE = 1
integer, public :: CUFFT_R2C = Z'2a' ! Real to Complex (interleaved)
integer, public :: CUFFT_C2R = Z'2c' ! Complex (interleaved) to Real
integer, public :: CUFFT_C2C = Z'29' ! Complex to Complex, interleaved
integer, public :: CUFFT_D2Z = Z'6a' ! Double to Double-Complex
integer, public :: CUFFT_Z2D = Z'6c' ! Double-Complex to Double
integer, public :: CUFFT_Z2Z = Z'69' ! Double-Complex to Double-Complex


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! cufftPlan1d(cufftHandle *plan, int nx,cufftType type,int batch)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


interface cufftPlan1d
subroutine cufftPlan1d(plan, nx, type, batch) bind(C,name='cufftPlan1d') 
use iso_c_binding
integer(c_int):: plan
integer(c_int),value:: nx, batch,type
end subroutine cufftPlan1d
end interface cufftPlan1d

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! cufftDestroy(cufftHandle plan)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

interface cufftDestroy
subroutine cufftDestroy(plan) bind(C,name='cufftDestroy') 
use iso_c_binding
integer(c_int),value:: plan
end subroutine cufftDestroy
end interface cufftDestroy

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! cufftExecC2C(cufftHandle plan,
! cufftComplex *idata,
! cufftComplex *odata,
! int direction)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

interface cufftExecC2C
subroutine cufftExecC2C(plan, idata, odata, direction) bind(C,name='cufftExecC2C') 
use iso_c_binding
use precision
integer(c_int),value :: direction
integer(c_int),value :: plan
complex(fp_kind),device:: idata(*),odata(*)
end subroutine cufftExecC2C
end interface cufftExecC2C

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! cufftExecZ2Z(cufftHandle plan,
! cufftDoubleComplex *idata,
! cufftDoubleComplex *odata,
! int direction);
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
interface cufftExecZ2Z
subroutine cufftExecZ2Z(plan, idata, odata, direction) bind(C,name='cufftExecZ2Z') 
use iso_c_binding
use precision
integer(c_int),value:: direction
integer(c_int),value:: plan
complex(fp_kind),device:: idata(*),odata(*)
end subroutine cufftExecZ2Z
end interface cufftExecZ2Z

end module cufft
