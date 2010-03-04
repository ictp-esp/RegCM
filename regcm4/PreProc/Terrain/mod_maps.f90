!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
!
!    This file is part of RegCM model.
!
!    RegCM model is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    RegCM model is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with RegCM model.  If not, see <http://www.gnu.org/licenses/>.
!
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      module mod_maps
      use mod_domain , only : iy , jx , nveg , ntex
      implicit none
      real(4) , dimension(iy,jx) :: claya , clayb , coriol , dlat ,     &
                                  & dlon , dmap , htgrid , htsdgrid ,   &
                                  & lndout , mask , sanda , sandb ,     &
                                  & snowam , texout , xlat , xlon , xmap
      real(4) , dimension(iy,jx,nveg) :: frac_lnd
      real(4) , dimension(iy,jx,ntex) :: frac_tex
      integer , dimension(iy,jx) :: intext , lnduse
      end module mod_maps
