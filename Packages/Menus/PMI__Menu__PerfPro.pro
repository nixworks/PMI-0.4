;Menu for the PerfPro version on

;REQUIRES PACKAGES:
;  Slices
;  Dynamic
;  Perfusion

;
;    Copyright (C) 2013 Steven Sourbron
;
;    This program is free software; you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation; either version 2 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License along
;    with this program; if not, write to the Free Software Foundation, Inc.,
;    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA



pro PMI__Menu__PerfPro, parent

    PMI__Menu__Skeleton, parent
    PMI__Menu__Slices, parent     ;PACKAGE: Slices
    PMI__Menu__Dynamic, parent    ;PACKAGE: Dynamic

    id = widget_button(parent, value='Perfusion',/menu)

        Sid = PMI__Button__SemiQuantitativePerfusion(id	, value='Semi-quantitative (Pixel)')   ;PACKAGE: Perfusion
        Sid = PMI__Button__FastDeconvolutionAnalysis(id, value='Model-free (Pixel)')           ;PACKAGE: Perfusion
        Sid = PMI__Button__FitModToftsLin(id, value='Modified Tofts (Pixel)')                  ;PACKAGE: Perfusion
        Sid = PMI__Button__FitSingleInletRoi(id, value='Exchange models (ROI)', /separator)    ;PACKAGE: Perfusion
        Sid = PMI__Button__KidneyModelsROI(id, value = 'Kidney models (ROI)')                  ;PACKAGE: Perfusion
        Sid = PMI__Button__FitDualInletRoi(id, value = 'Liver models (ROI)')                   ;PACKAGE: Perfusion

    id = widget_button(parent, value='DCE-MRI',/menu)

        Sid = PMI__Button__FitModToftsLinPopAif(id, value='Modified Tofts (Pixel - population AIF)')                ;PACKAGE: Perfusion
        Sid = PMI__Button__FitSingleInletRoiPVcorr(id, value='Exchange models (ROI - partial volume correction)')   ;PACKAGE: Perfusion
        Sid = PMI__Button__FitSingleInletRoiNormAif(id, value='Exchange models (ROI - normalised AIF)') ;PACKAGE:

    id = widget_button(parent, value='Recon',/menu)

 		Sid = PMI__Button__SlicesAxialToCoronal(id)
 		Sid = PMI__Button__SlicesCoronalToSagittal(id)
 		Sid = PMI__Button__SlicesSagittalToAxial(id)

end
