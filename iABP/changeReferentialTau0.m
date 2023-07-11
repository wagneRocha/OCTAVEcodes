function T0 = changeReferentialTau0(phase, T1)

	T0 = T1;
	T0.m = phase + T0.m;
	
	if(T0.m < -pi)
		T0.m = 2*pi + T0.m;
	elseif(pi < T0.m)
		T0.m = -2*pi + T0.m;
	end
end
