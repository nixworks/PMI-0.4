pro PMI__Button__Event__FitFiltrationRoi, ev

	PMI__Info, ev.top, stdy=Stdy

	if not TumorRoiAnalysis__input($
		ev.top $
	,	status	= status $
	,	time 	= time $
	,	curve 	= curve $
	,	aif		= aif $
	,	Units	= units $
	,	Roi		= Roi $
	,	ev=ev ) $
	then begin
		PMI__Message, Status
		return
     endif

	P = [0.3, 120.0/6000, 2.0/3, 12/132.] ;[VP+VE, FP, VE/(VP+VE), FE/FP]
	Fit = FitSingleInlet('Filtration', time, aif, curve, P, AKAIKE_ERROR=aic, /POSITIVITY, LIMITED_ABOVE=[0,0,1,0])

	PMI__Control, ev.top, Viewer = 'PMI__Display__PerfusionRoiOutput', Display=Display

	Display -> Set, /Refresh $
	,	Model = 'Two-compartment filtration model' $
	,	Time = Time $
	,	Curve = Curve $
	,	Fit = Fit $
	,	Units = Units $
	,	RoiName = Roi->Name() $
	,	Parameters = $
		[{Name:'Plasma Flow'					,Units:'ml/100ml/min'	,Value:6000D*P[1]	,Nr: 0,Rnd:1} $
		,{Name:'Plasma MTT'						,Units:'sec'			,Value:1D*P[0]*(1-P[2])/P[1] 		,Nr: 1,Rnd:1} $
		,{Name:'Plasma Volume'					,Units:'ml/100ml'		,Value:100D*P[0]*(1-P[2])			,Nr: 2,Rnd:1} $
		,{Name:'EES MTT'				,Units:'sec'			,Value:1D*P[0]*P[2]/(P[1]*P[3])		,Nr: 3,Rnd:1} $
		,{Name:'ESS Volume'			,Units:'ml/100ml'		,Value:100D*P[0]*P[2]	,Nr: 4,Rnd:1} $
		,{Name:'Extraction Fraction'			,Units:'%' 			,Value:100D*P[3]		,Nr: 5,Rnd:1} $
		,{Name:'Permeability-surface area product (PS)'				,Units:'ml/100ml/min'	,Value:6000D*P[1]*P[3]	,Nr: 6,Rnd:1} $
		,{Name:'Akaike Fit Error'				,Units:''			,Value:AIC				,Nr:14,Rnd:1} ]

end


pro PMI__Button__Control__FitFiltrationRoi, id, v

	PMI__Info, tlb(id), Stdy=Stdy
	if obj_valid(Stdy) then begin
		Series = Stdy->Names(0,ns,DefDim=3)
		Regions = Stdy->Names(1,nr)
		sensitive = (ns gt 0) and (nr gt 1)
	endif else sensitive=0
    widget_control, id, sensitive=sensitive
end

function PMI__Button__FitFiltrationRoi, parent,value=value, separator=separator

	SingleInletFiltration
	PMI__Display__PerfusionRoiOutput__Define

	if n_elements(value) eq 0 then value = 'Fit 2-compartment filtration model (ROI)'

	id = widget_button(parent 						$
	,	value 		= value		$
	,	event_pro 	= 'PMI__Button__Event__FitFiltrationRoi'	$
	,	pro_set_value 	= 'PMI__Button__Control__FitFiltrationRoi' $
	, 	separator 	= separator						)

	return, id

end
