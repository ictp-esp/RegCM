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

      module mod_crdcae
      implicit none
!
! COMMON /CRDCAE/
!
      real(8) , dimension(2) :: a1 , a2 , b1 , b2 , realk , st
      real(8) , dimension(4) :: c1 , c2 , c3 , c4 , c5 , c6 , c7
      real(8) :: c10 , c11 , c12 , c13 , c14 , c15 , c16 , c17 , c18 ,  &
               & c19 , c20 , c21 , c22 , c23 , c24 , c25 , c26 , c27 ,  &
               & c28 , c29 , c30 , c31 , c8 , c9 , cfa1 , fc1 , fwc1 ,  &
               & fwc2 , fwcoef
      real(8) , dimension(3,4) :: coefa , coefc , coefe
      real(8) , dimension(4,4) :: coefb , coefd
      real(8) , dimension(6,2) :: coeff , coefi
      real(8) , dimension(2,4) :: coefg , coefh
      real(8) , dimension(3,2) :: coefj , coefk
!
!     /CRDCAE/
!     H2O EMISSIVITY AND ABSORTIVITY COEFFICIENTS
!
      data coefa/1.01400E+00 , 6.41695E-03 , 2.85787E-05 , 1.01320E+00 ,&
         & 6.86400E-03 , 2.96961E-05 , 1.02920E+00 , 1.01680E-02 ,      &
         & 5.30226E-05 , 1.02743E+00 , 9.85113E-03 , 5.00233E-05/
!
      data coefb/8.85675E+00 , -3.51620E-02 , 2.38653E-04 ,             &
         & -1.71439E-06 , 5.73841E+00 , -1.91919E-02 , 1.65993E-04 ,    &
         & -1.54665E-06 , 6.64034E+00 , 1.56651E-02 , -9.73357E-05 ,    &
         & 0.0 , 7.09281E+00 , 1.40056E-02 , -1.15774E-04 , 0.0/
!
      data coefc/9.90127E-01 , 1.22475E-03 , 4.90135E-06 , 9.89753E-01 ,&
         & 1.97081E-03 , 3.42046E-06 , 9.75230E-01 , 1.03341E-03 , 0.0 ,&
         & 9.77366E-01 , 8.60014E-04 , 0.0/
!
      data coefd/7.03047E-01 , -2.63501E-03 , -1.57023E-06 , 0.0 ,      &
         & 5.29269E-01 , -3.14754E-03 , 4.39595E-06 , 0.0 ,             &
         & 7.88193E-02 , 1.31290E-03 , 4.25827E-06 , -1.23982E-08 ,     &
         & 1.62744E-01 , 2.22847E-03 , 2.60102E-06 , -4.30133E-08/
!
      data coefe/3.93137E-02 , -4.34341E-05 , 3.74545E-07 ,             &
         & 3.67785E-02 , -3.10794E-05 , 2.94436E-07 , 7.42500E-02 ,     &
         & 3.97397E-05 , 0.0 , 7.52859E-02 , 4.18073E-05 , 0.0/
!
      data coeff/2.2037E-01 , 1.39719E-03 , -7.32011E-06 ,              &
         & -1.40262E-08 , 2.13638E-10 , -2.35955E-13 , 3.07431E-01 ,    &
         & 8.27225E-04 , -1.30067E-05 , 3.49847E-08 , 2.07835E-10 ,     &
         & -1.98937E-12/
!
      data coefg/9.04489E+00 , -9.56499E-03 , 1.80898E+01 ,             &
         & -1.91300E-02 , 8.72239E+00 , -9.53359E-03 , 1.74448E+01 ,    &
         & -1.90672E-02/
!
      data coefh/5.46557E+01 , -7.30387E-02 , 1.09311E+02 ,             &
         & -1.46077E-01 , 5.11479E+01 , -6.82615E-02 , 1.02296E+02 ,    &
         & -1.36523E-01/
!
      data coefi/3.31654E-01 , -2.86103E-04 , -7.87860E-06 ,            &
         & 5.88187E-08 , -1.25340E-10 , -1.37731E-12 , 3.14365E-01 ,    &
         & -1.33872E-03 , -2.15585E-06 , 6.07798E-08 , -3.45612E-10 ,   &
         & -9.34139E-15/
!
      data coefj/2.82096E-02 , 2.47836E-04 , 1.16904E-06 , 9.27379E-02 ,&
         & 8.04454E-04 , 6.88844E-06/
!
      data coefk/2.48852E-01 , 2.09667E-03 , 2.60377E-06 , 1.03594E+00 ,&
         & 6.58620E-03 , 4.04456E-06/
!
!
!     Narrow band data for H2O
!     200CM data for 800-1000 CM-1 and 1000-1200 CM-1.
!
      data realk/0.18967069430426E-04 , 0.70172244841851E-04/
      data st/0.31930234492350E-03 , 0.97907319939060E-03/
      data a1/0.28775403075736E-01 , 0.23236701470511E-01/
      data a2/ - 0.57966222388131E-04 , -0.95105504388411E-04/
      data b1/0.29927771523756E-01 , 0.21737073577293E-01/
      data b2/ - 0.86322071248593E-04 , -0.78543550629536E-04/

      end module mod_crdcae
