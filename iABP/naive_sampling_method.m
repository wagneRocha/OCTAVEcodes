function sample = naive_sampling_method(I, h, numSamples, myZero)
  
	sample = zeros(1,numSamples);
	
	numInter = size(I,1);
	Li = zeros(numInter, 1);
	for i = 1 : numInter
		Li(i) = I(i,2) - I(i,1);
	end
	
	sample(1) = I(1,1);
	
	j = 1;
	maxLj = I(j,1) + Li(j);
	for k = 2 : numSamples
		candidate = sample(k-1) + h;
		if((candidate < maxLj) || (abs(candidate - maxLj) < myZero))
			sample(k) = sample(k-1) + h;
		else
			hPercorrido = I(j,2) - sample(k-1);
			j = j + 1;
			sample(k) = I(j,1) + hPercorrido - h;
			maxLj = I(j,1) + Li(j);
		end
	end
end
