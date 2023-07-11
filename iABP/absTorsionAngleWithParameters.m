function absTau = absTorsionAngleWithParameters(nu, mu, d14)

	d14d14 = d14*d14;
	dmin2  = nu-2*mu;
	dmax2  = nu+2*mu;

	if((dmin2 < d14d14) && (d14d14 < dmax2))
		cost = roundoct((nu - d14d14)/(2*mu), 12);
	elseif(d14d14 <= dmin2)
		cost = 1;
	elseif(dmax2 <= d14d14)
		cost = -1;
	end

	absTau = acos(cost);
end
