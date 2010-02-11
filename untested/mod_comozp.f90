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

      module mod_comozp


      implicit none
!
! PARAMETER definitions
!
      integer , parameter :: pnoz = 100 , pozlon = 1
!
! COMMON /COMOZP/
!
      real(8) :: cplol , cplos , ldoyoz , ndoyoz
      real(8) , dimension(1,pnoz) :: ozmix
      real(8) , dimension(pozlon,pnoz,1,2) :: ozmixm
      real(8) , dimension(pnoz) :: pin
!
! COMMON /IOZNCT/
!
      integer :: koz , nyroz
      end module mod_comozp
