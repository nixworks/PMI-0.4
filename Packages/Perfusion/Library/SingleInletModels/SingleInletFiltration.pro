;MODEL PARAMETERS

;P = [V, FP, v, E]

;DEFINED AS FOLLOWS

;V = VP+VE	(Total Extracellular Volume)
;FP (Plasma Flow)
;v = VE/(VP+VE)  (Extravascular Volume Fraction)
;E = FE/FP  (Extraction Fraction)

;FITTED FUNCTION

;C(t) = FP (1-A) exp(-tKP)*Ca(t) + FP A exp(-tKE)*Ca(t)

;FIT PARAMETERS

;FP, A, KP, KE

;DEFINED AS FOLLOWS IN TERMS OF THE MODEL PARAMETERS

;KP = FP/VP = FP / [V (1-v)]
;KE = FE/VE = E FP / [V v ]
;A = 1/[1 + 1/E - 1/v]

;
;
;    Copyright (C) 2012 Steven Sourbron
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
;
;
;


Pro SingleInletFiltration, X, P, C, C_DER

	if n_params() eq 0 then return

	ni=X[0] & n=n_elements(X[ni+1:*])/2
	ti=X[1:ni] & time=X[ni+1:ni+n] & input=X[ni+n+1:*]

	KP = P[1]/(P[0]*(1-P[2]))
	KE = P[3]*P[1]/(P[0]*P[2])
	A = 1/(1+1/P[3]-1/P[2])

	convP = ExpConvolution(KP,[time,input],Der=dconvP)
	convE = ExpConvolution(KE,[time,input],Der=dconvE)

	C = P[1]*(1-A)*convP[ti] + P[1]*A*convE[ti]

	IF n_params() LT 4 THEN return

	;Derivatives wrt model parameters

	dKP0 = -P[1]/(P[0]^2*(1-P[2]))
	dKP1 = 1/(P[0]*(1-P[2]))
	dKP2 = P[1]/(P[0]*(1-P[2])^2)

	dKE0 = -P[3]*P[1]/(P[0]^2*P[2])
	dKE1 = P[3]/(P[0]*P[2])
	dKE2 = -P[3]*P[1]/(P[0]*P[2]^2)
	dKE3 = P[1]/(P[0]*P[2])

	dA2 = -(A/P[2])^2
	dA3 = (A/P[3])^2

	dC0 = P[1]*(1-A)*dconvP[ti]*dKP0 + P[1]*A*dconvE[ti]*dKE0
	dC1 = (1-A)*convP[ti] + A*convE[ti] + P[1]*(1-A)*dconvP[ti]*dKP1 + P[1]*A*dconvE[ti]*dKE1
	dC2 = P[1]*(1-A)*dconvP[ti]*dKP2 - P[1]*dA2*convP[ti] + P[1]*A*dconvE[ti]*dKE2 + P[1]*dA2*convE[ti]
	dC3 = -P[1]*dA3*convP[ti] + P[1]*A*dconvE[ti]*dKE3 + P[1]*dA3*convE[ti]

	C_DER = [[dC0],[dC1],[dC2],[dC3]]
end