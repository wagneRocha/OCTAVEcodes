function call_iABP(idCode, chain, ddgpHCorder, myZero, timeMax, sampleSize, numReps, method, fnI, fnX, fnT, outputFileDir)

	[I0, resSeq, resName, AtomsOrder] = loadMDjeepFile(fnI);
	X = load(fnX);
	T = load(fnT);
	saveCoordenatesPDBformat([outputFileDir, '/', idCode, '/X_pdb.pdb'], AtomsOrder, resName, chain, resSeq, X, 'PDB', idCode);

	m = size(I0,1);
	n = I0(m,1);

	cliques	       = DDGPcliques(ddgpHCorder, n);
	knownChirality = knownDDGPcliqueChirality(ddgpHCorder, n);
	chirality      = getDDGPcliqueChirality(X, cliques, knownChirality);

	[I, kv] = instance2adjList(I0);
	[ddgpParameters, X0, Iid, ku] = adjList2myFormatiBP(I, kv, T, cliques, chirality, ddgpHCorder);

	isArc = verifyTreeArcs(ddgpParameters);

	Xcalc = zeros(n, 3);
	Xcalc(1:3,:) = X0;

	%% method
	telapsed = zeros(numReps, 1);
	for k = 1 : numReps
		flag = 0;
		tstart = tic;
		[X_calc, imax, numIt] = iABP(Xcalc, n, ddgpParameters, Iid, ku, isArc, sampleSize, myZero, timeMax);
		telapsed(k) = toc(tstart);

		if(abs(telapsed(k) - timeMax) < 0.01)
			flag = 1;
			break;
		end
	end
	averageTime = mean(telapsed);
	stdTime	 = std(telapsed);
	%%
	if(not(isempty(X_calc)))
		saveCoordenatesPDBformat([outputFileDir, '/', idCode, '/X_order', num2str(ddgpHCorder), '_', method,'.pdb'], AtomsOrder, resName, chain, resSeq, X_calc, method, idCode);
	end

	newFile = [outputFileDir, 'results_', method,'.dat'];
	resFile = fopen(newFile, 'a');
	saveResults(resFile, lower(idCode), ddgpHCorder, X, X_calc, I0, averageTime, stdTime, flag, imax, numIt)

	fclose(resFile);
end
