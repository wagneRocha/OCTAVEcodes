function saveResults(resFile, idCode, ddgpHCorder, X, X_calc, I0, averageTime, stdTime, flag, imax, numIt)

	n = size(X,1);
	fprintf(resFile, '%s & $%d$ & ', idCode, ddgpHCorder);

	if(~flag)
		fprintf(resFile, '$%.2f \\pm %.2f$ & $%d$ & ', averageTime, stdTime, numIt);
	else
		fprintf(resFile, '$\\infty$ & $%d$ & ', numIt);
	end
    
	if(~isempty(X_calc))
		[rmsd, ~, ~] = calculaRMSD(X_calc, X);
		[~, lde]  = calculaMDEeLDE(X_calc, I0);
    	[~, lde0] = calculaMDEeLDE(X, I0);
        fprintf(resFile, '$%.2f$ & $%.2f$ & $%d$ \\\\\n', abs(lde - lde0), rmsd, imax-1);
	else
		fprintf(resFile, '$--$ & $--$ & $%d$ \\\\\n', imax);
	end
	
	fprintf(resFile, '\\hline\n');
	
    	if(~isempty(X))
        	satisfiesInstanceQM(X, I0)
	end
	if(~isempty(X_calc))
		satisfiesInstanceQM(X_calc, I0)
	end
end
