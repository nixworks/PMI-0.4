
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
;    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


pro PMI__Menu__Window, parent

	id 	= widget_button(parent, value = 'Display', /menu)

	Sid = PMI__Button__Standard2dView(id)
	Sid = PMI__Button__2d1dView(id)
	Sid = PMI__Button__2d2dView(id)
	Sid = PMI__Button__ViewRoiCurve(id,/separator)
	Sid = PMI__Button__ViewRoiHistogram(id)
	Sid = PMI__Button__DisplayImage(id,/separator)
	Sid = PMI__Button__DisplayVolume(id)
	Sid = PMI__Button__SeriesEditDicomHeader(id, value='DICOM Header',/separator)

	Sid = PMI__Button__About(id,/separator)

end