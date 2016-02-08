program fft_test
use precision
use cufft
complex(fp_kind) ,allocatable:: a(:),b(:)
complex(fp_kind),device,allocatable:: a_d(:),b_d(:)

integer:: n
integer:: plan

n=8

! allocate arrays on the host
allocate (a(n),b(n))

! allocate arrays on the device
allocate (a_d(n))
allocate (b_d(n))

!initialize arrays on host
a=1

!copy arrays to device
a_d=a


! Print initial array
print *, "Array A:"
print *, a



! Initialize the plan
call cufftPlan1D(plan,n,CUFFT_Z2Z,1)

! Execute FFTs
call cufftExecZ2Z(plan,a_d,b_d,CUFFT_FORWARD)

call cufftExecZ2Z(plan,b_d,b_d,CUFFT_INVERSE)


! Copy results back to host
b=b_d

! Print initial array
print *, "Array B"
print *, b

!release memory on the host
deallocate (a,b)

!release memory on the device
deallocate (a_d,b_d)

! Destroy the plan
call cufftDestroy(plan)

end program fft_test
