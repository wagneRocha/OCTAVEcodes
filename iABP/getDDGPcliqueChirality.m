function vecChi = getDDGPcliqueChirality(X, cliques, knownChirality)

	n = size(X,1);
	vecChi = zeros(n,1);
	for k = 4 : n
		if(knownChirality(k))
			x1 = X(cliques(k,4),:);
			x2 = X(cliques(k,3),:);
			x3 = X(cliques(k,2),:);
			x4 = X(cliques(k,1),:);
			
			vecChi(k) = signTorsionAngle(x1, x2, x3, x4);
		end
	end
end
