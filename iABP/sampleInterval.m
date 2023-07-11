function [branches, branchNum] = sampleInterval(I, isArc, numSamples, myZero)

	I = juntaIntervalos(I, myZero);
	numIntervals = size(I,1);

	if(isArc)
		[branches, branchNum] = naive_sampling(I, numSamples, myZero);
	else
		if(numIntervals == 1)
			branches = nan(1, 2*numSamples);
			branches(2*numSamples) = I(1,1);
			branchNum = 2*numSamples;
		else
			branches = nan(1, 2*numSamples);
			branches(2*numSamples - 1 : 2*numSamples) = [I(1,1), I(2,1)];
			branchNum = 2*numSamples - 1;
		end
	end
end
