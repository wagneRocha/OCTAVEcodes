function satisfiesInstanceQM(X, I)
	
	[numberOfMeasures,~] = size(I);
	flags = ones(numberOfMeasures,1);
	
	l = 0;
	for k = 1 : numberOfMeasures
		xi = X(I(k,1), :);
		xj = X(I(k,2), :);
		
		ndd = 2;
		d  = roundoct(norm(xi - xj), ndd);
		dl = roundoct(I(k,3), ndd);
		du = roundoct(I(k,4), ndd);
		
		if((dl <= d) && (d <= du))
			flags(k) = 0;
		else
			l = l + 1;
			[I(k,1) I(k,2) dl d du]
		end
	end
	if(sum(flags) == 0)
		fprintf('X Satisfies the Instance\n')
	else
		fprintf('X does not Satisfies the Instance: %d wrong edges were detected\n', l)
	end
end
