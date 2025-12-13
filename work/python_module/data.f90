program main
  implicit none
  integer(4), parameter :: rp = kind(0.0d0)
  real(rp), parameter :: pi = 4.0_rp * atan(1.0_rp)
  integer(4), parameter :: nx = 200, ny = 100
  real(rp) :: data(nx,ny)
  integer(4) :: ix, jy

  do jy = 1, ny
     do ix = 1, nx
        data(ix,jy) = sin(2*pi*(ix-1)/nx) + cos(4*pi*(jy-1)/ny)
     end do
  end do

  open(10,file="data.dat",form="unformatted",access="stream",convert="big_endian")
  write(10) nx,ny
  write(10) data
  close(10)
end program main
