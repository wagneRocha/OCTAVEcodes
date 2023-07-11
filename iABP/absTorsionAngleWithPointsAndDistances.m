function absTau = absTorsionAngleWithPointsAndDistances(x1, x2, x3, d14, d24, d34)

	d12 = norm(x1-x2);
	d13 = norm(x1-x3);
	d23 = norm(x2-x3);
    
	absTau = absTorsionAngleWithDistances(d12, d13, d14, d23, d24, d34);
end
