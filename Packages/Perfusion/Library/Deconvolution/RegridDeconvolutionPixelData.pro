;
;
;    Copyright (C) 2005 Steven Sourbron
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


function RegridDeconvolutionData, time, aif, time_regr, aif_regr

	time_regr = time
	aif_regr = aif

	n = n_elements(aif)
	dtime = time[1:n-1]-time[0:n-2]
	dt = min(dtime,max=mdt)
	if dt eq 0 then dt=1.0
	if (mdt-dt)/dt lt 0.01 then return, 0

	n = 1+ floor(time[n-1]/dt)
	time_regr = dt*dindgen(n)
	aif_regr = interpol(aif,time,time_regr)

	return, 1
end

pro RegridDeconvolutionPixelData,time,p,aif,time_regr=time_regr,aif_regr=aif_regr

	if not RegridDeconvolutionData(time, aif, time_regr, aif_regr) then return

	d = size(p,/dimensions)
	nt = n_elements(time_regr)
	p_regr = fltarr(d[0],nt)
	for i=0L,d[0]-1 do begin
		curve = reform(p[i,*],/overwrite)
		p_regr[i,*] = interpol(curve,time,time_regr)
	endfor
	p = p_regr

end