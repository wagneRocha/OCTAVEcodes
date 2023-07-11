function I = multiplyInterval(I1, I2, myZero)
	
	a0aux = I1.m - I1.delta;
	b0aux = I1.m + I1.delta;
	a1aux = I2.m - I2.delta;
	b1aux = I2.m + I2.delta;

	if((a0aux < a1aux) || (abs(a0aux - a1aux) < myZero))
		b0 = b0aux;
		a1 = a1aux;
		b1 = b1aux;
	else
		b0 = b1aux;
		a1 = a0aux;
		b1 = b0aux;
	end
	
	if((a1 < b0) || (abs(a1 - b0) < myZero))
		a = a1;
		b = min(b0, b1);
		I.m = (a + b)/2;
		I.delta = abs(a - b)/2;
	else
		I = [];
	end
end
