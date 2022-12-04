! 2022-12-02
! created by MATSUBA Fumitaka
! direct形式のデータを一度変換する
program main
   implicit none
   integer(4) :: nx,ny
   character(60) :: fname
   real(4),allocatable :: topo(:,:)
   namelist/nampar/ nx,ny,fname
   
   nx = 481
   ny = 505
   fname = "TOPO.MSM_5K"

   ! 標準出力からnamelistを読む
   read(5,nampar)
   
   allocate(topo(nx,ny))

   open(10,file=fname,form="unformatted",status="old", &
        & access="direct", recl=4*nx*ny, convert="BIG_ENDIAN")
   read(10,rec=1) topo(1:nx,1:ny)
   close(10)

   open(11,file="topo.dat",form="unformatted")
   write(11) nx,ny
   write(11) topo(1:nx,1:ny)
   close(11)

   print*, 'max = ', maxval(topo)
   print*, 'min = ', minval(topo)
   deallocate(topo)
end program main
