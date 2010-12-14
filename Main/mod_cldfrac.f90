!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
!
!    This file is part of ICTP RegCM.
!
!    ICTP RegCM is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    ICTP RegCM is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with ICTP RegCM.  If not, see <http://www.gnu.org/licenses/>.
!
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 
      module mod_cldfrac
!
!     Fractional cloud coverage and liquid water content
!
      use mod_constants
      use mod_dynparam
      use mod_pmoist
      use mod_rad
      use mod_slice
!
      private
!
      public :: cldfrac
!
      contains
!
!cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!                                                                     c
!     This subroutine computes the fractional cloud coverage and      c
!     liquid water content (in cloud value).  Both are use in         c
!     radiation.                                                      c
!                                                                     c
!     The fractional coverage of large scale clouds is a function of  c
!     relative humidity, using the relationship of sundqvist et       c
!     al., 1989.  The relative humidity at which clouds begin to      c
!     form is lower over land than ocean, due to the greater number   c
!     of cloud condensation nucleii.                                  c
!                                                                     c
!     The fracional coverage of convective clouds is passed in from   c
!     the convection scheme.                                          c
!                                                                     c
!     The large-scale and convective clouds are combined as follows:  c
!     1) If the convective cloud fraction > large scale fraction, the c
!     convective fraction and water content are used (this occurs     c
!     infrequently).                                                  c
!     2) Otherwise, the cloud fraction equals the large-scale         c
!     fraction AND the water content is a weighted average of both    c
!     types.                                                          c
!                                                                     c
!     Note: the incloud water content (g/m3) is passed to radiation   c
!                                                                     c
!     See Pal et al (200) for more info.                              c
!                                                                     c
!cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!
      subroutine cldfrac(j)
!
      implicit none
!
      integer :: j
      intent (in) j
!
      real(8) :: exlwc , rh0adj
      integer :: i , k
!
!--------------------------------------------------------------------
!     1.  Determine large-scale cloud fraction
!--------------------------------------------------------------------
      do k = 1 , kz         ! Adjusted relative humidity threshold
        do i = 2 , iym2
          if ( tb3d(i,k,j).gt.tc0 ) then
            rh0adj = rh0(i,j)
          else ! high cloud (less subgrid variability)
            rh0adj = rhmax - (rhmax-rh0(i,j))                           &
                   & /(1.0+0.15*(tc0-tb3d(i,k,j)))
          end if
          if ( rhb3d(i,k,j).ge.rhmax ) then    ! full cloud cover
            fcc(i,k,j) = 1.
          else if ( rhb3d(i,k,j).le.rh0adj ) then
                                               ! no cloud cover
            fcc(i,k,j) = 0.
          else                                ! partial cloud cover
            fcc(i,k,j) = 1. - sqrt(1.-(rhb3d(i,k,j)-rh0adj)/(rhmax-     &
                       & rh0adj))
            fcc(i,k,j) = dmin1(dmax1(fcc(i,k,j),0.01D0),0.99D0)
          end if                      !  rh0 threshold
!---------------------------------------------------------------------
! Correction:
! Ivan Guettler, 14.10.2010.
! Based on: Vavrus, S. and Waliser D., 2008, 
! An Improved Parameterization for Simulating Arctic Cloud Amount
!    in the CCSM3 Climate Model, J. Climate 
!---------------------------------------------------------------------
          if ( pb3d(i,k,j) >= 75.0 ) then
            ! Clouds below 750hPa
            if ( qvb3d(i,k,j).le.0.003D0 ) then
              fcc(i,k,j) = fcc(i,k,j) * &
                        max(0.15D0,min(1.0D0,qvb3d(i,k,j)/0.003D0))
            end if
          end if
        end do
      end do

!---------------------------------------------------------------------
! End of the correction.
!---------------------------------------------------------------------
!--------------------------------------------------------------------
!     2.  Combine large-scale and convective fraction and liquid water
!     to be passed into radiation.
!--------------------------------------------------------------------
      do k = 1 , kz
        do i = 2 , iym2
          ! Cloud Water Volume
          ! kg gq / kg dry air * kg dry air / m3 * 1000 = g qc / m3
          exlwc = qcb3d(i,k,j)*rhob3d(i,k,j)*1.E03

          ! temperature dependance for convective cloud water content
          ! in g/m3 (Lemus et al., 1997)
          cldlwc(i,k)  = 0.127D+00 + 6.78D-03*(tb3d(i,k,j)-tzero)    &
                       &  + 1.29D-04* (tb3d(i,k,j)-tzero)**2    &
                       &  + 8.36D-07*(tb3d(i,k,j)-tzero)**3

          if ( cldlwc(i,k) > 0.3D+00 ) cldlwc(i,k) = 0.3D+00
          if ( (tb3d(i,k,j)-tzero) < -50D+00 ) cldlwc(i,k) = 0.001D+00
          exlwc = cldlwc(i,k)
          cldlwc(i,k) = (cldfra(i,k)*cldlwc(i,k)+fcc(i,k,j)*exlwc) &
                      & /dmax1(cldfra(i,k)+fcc(i,k,j),0.01D0)
          cldfra(i,k) = dmin1(dmax1(cldfra(i,k),fcc(i,k,j)),fcmax)
        end do
      end do
 
      end subroutine cldfrac
!
      end module mod_cldfrac
