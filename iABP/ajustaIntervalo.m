function I = ajustaIntervalo(I)

   	ncd = 4;

	a = I.m - I.delta;
	b = I.m + I.delta;
	
	if((abs(a) > abs(b)) && (roundoct(a, ncd) + pi < -0.0001))
		ap = a;
		bp = -pi;
		an = -pi;
		bn = b;
		In.m	 = (an+bn)/2;
		In.delta = abs(an-bn)/2;
		Ip.m	 = (ap+bp)/2;
		Ip.delta = abs(ap-bp)/2;
		Ip.m = 2*pi + Ip.m;
		I = [In; Ip];
	elseif((abs(b) > abs(a)) && (roundoct(b, ncd) - pi > 0.0001))
		ap = a;
		bp = pi;
		an = pi;
		bn = b;
		Ip.m	 = (ap+bp)/2;
		Ip.delta = abs(ap-bp)/2;
		In.m	 = (an+bn)/2;
		In.delta = abs(an-bn)/2;
		In.m = -2*pi + In.m;
		I = [In; Ip];
	end
end
