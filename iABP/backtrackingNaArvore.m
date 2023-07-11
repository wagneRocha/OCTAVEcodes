function [i, exploredVertex, branches, branchNum] = backtrackingNaArvore(i, exploredVertex, branches, branchNum, sampleSize)
	exploredVertex(i) = 0;
	i = i - 1;
	while(1)
		branches(i, branchNum(i)) = NaN;
		if(branchNum(i) < sampleSize)
			break;
		else
			exploredVertex(i) = 0;
			i = i - 1;
		end
	end
end
