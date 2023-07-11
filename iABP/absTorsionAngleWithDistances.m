function absTau = absTorsionAngleWithDistances(d12, d13, d14, d23, d24, d34)

	kbar = kappai(d12, d23, d13);
	k    = kappai(d24, d23, d34);
	rhobar2 = rhoi2(d12, kbar);
	rho2    = rhoi2(d24, k);
	
	nu = (k - kbar)*(k - kbar) + rhobar2 + rho2;
	mu = sqrt(rhobar2*rho2);
    
    	absTau = absTorsionAngleWithParameters(nu, mu, d14);
end
