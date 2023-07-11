function [branches, branchNum] = naive_sampling(I, numSamples, myZero)

	numIntervals = size(I,1);
	In = [];
	Ip = [];
	for k = 1 : numIntervals
		if(I(k,1) < 0)
			In = [In; I(k,:)];
		else
			Ip = [Ip; I(k,:)];
		end
	end
	nni = size(In,1);
	npi = size(Ip,1);
	
	Ln = 0;
	for k = 1 : nni
		Ln = Ln + In(k, 2) - In(k, 1);
	end
	Lp = 0;
	for k = 1 : npi
		Lp = Lp + Ip(k, 2) - Ip(k, 1);
	end
	
	if(Ln == 0)
		branchesN = NaN(1, numSamples);
	else
		hn = linspace(0, Ln, numSamples);
		hn = hn(2) - hn(1);
		branchesN = naive_sampling_method(In, hn, numSamples, myZero);
	end
	if(Lp == 0)
		branchesP = NaN(1, numSamples);
	else
		hp = linspace(0, Lp, numSamples);
		hp = hp(2) - hp(1);
		branchesP = naive_sampling_method(Ip, hp, numSamples, myZero);
	end
	
	if(isnan(branchesN(1)))
		branches  = [branchesN, branchesP];
		branchNum = numSamples + 1;
	elseif(isnan(branchesP(1)))
		branches  = [branchesP, branchesN];
		branchNum = numSamples + 1;
	else
		branches  = [branchesN, branchesP];
		branchNum = 1;
	end
end
