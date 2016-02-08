use cudafor

interface
  subroutine dgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc) bind(c,name='cublasDgemm')
   use iso_c_binding
   integer(c_int), value :: m, n, k, lda, ldb, ldc
   real(c_double), device, dimension(m,n) :: a, b, c
   real(c_double), value :: alpha, beta
   character(kind=c_char), value :: transa, transb
  end subroutine dgemm

  subroutine cublasinit() bind(c,name='cublasInit')
  end subroutine cublasinit

end interface


real(8), dimension(1000,1000) :: a, b, c
real(8), device, dimension(1000,1000) :: dA, dB, dC
real(8) :: alpha, beta
integer :: m,n,k,lda,ldb,ldc

m = 100
n = 100
k = 100
lda = 100
ldb = 100
ldc = 1000
alpha = 1.0d0
beta = 0.0d0

call cublasinit()

dA = a
dB = b
call dgemm('n','n',m,n,k,alpha,dA,lda,dB,ldb,beta,dC,ldc)
c = dC

stop
end
