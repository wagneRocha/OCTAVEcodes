function [a,b,c] = cirfunferenceParameters(x1, x2, x3, ddgpParameters)

	d12 = norm(x1 - x2);
	d13 = norm(x1 - x3);
	d23 = norm(x2 - x3);
	
	d24 = ddgpParameters.d24;
	d34 = ddgpParameters.d34;
	
	rhat = (x3 - x2)/d23;
	v	= x1 - x2;
	
	kbar  = kappai(d12, d23, d13);
	pbar2 = rhoi2(d12, kbar);
	
	k  = kappai(d24, d23, d34);
	p2 = rhoi2(d24, k);
	
	mu = sqrt(pbar2*p2);

	a = x2 + k*rhat;
	b = (p2/mu)*(v - kbar*rhat);
	c = cross(rhat, b);
end
