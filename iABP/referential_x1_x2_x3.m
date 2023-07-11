function X0 = referential_x1_x2_x3(d12, d13, d23)
	
	d12d12 = d12*d12;
	d12cosTh = 0.5*(d12d12 + d23*d23 - d13*d13)/d23;
	d12sinTh = sqrt(d12d12 - d12cosTh*d12cosTh);
	
	x1 = [-d12sinTh, d12cosTh - d23, 0];
	x2 = [0, -d23, 0];
	x3 = [0, 0, 0];
    
	X0 = [x1; x2; x3];
end
