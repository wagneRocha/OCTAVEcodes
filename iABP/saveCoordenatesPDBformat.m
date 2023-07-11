function saveCoordenatesPDBformat(finename, atomName, resName, chainName, resSeq, X, method, pdb_id)

	newFile = fopen(finename, 'w');
	fprintf(newFile, 'HEADER                                                %s   %s        \n', date(), pdb_id);

	if(strcmp(method,'ibp'))
		fprintf(newFile, 'TITLE     iBP solution                                                          \n');
	elseif(strcmp(method,'iap'))
		fprintf(newFile, 'TITLE     iABP solution                                                         \n');
	elseif(strcmp(method,'itbp'))
		fprintf(newFile, 'TITLE     iTBP solution                                                         \n');
	elseif(strcmp(method,'bp'))
		fprintf(newFile, 'TITLE     BP solution                                                           \n');
	else
		fprintf(newFile, 'TITLE     PDB structure                                                         \n');
	end

	fprintf(newFile, 'MODEL        1                                                                  \n');
	for k = 1 : length(X)
		if(length(atomName{k}) == 4)
			aName = atomName{k};
		elseif(length(atomName{k}) == 3)
			aName = [atomName{k}, ' '];
		elseif(length(atomName{k}) == 2)
			aName = [atomName{k}, '  '];
		else
	        	aName = [atomName{k}, '   '];
		end

		fprintf(newFile, 'ATOM   %4.0f %s %s %s %3.0f     %7.3f %7.3f %7.3f %5.2f %5.2f           %s  \n', ...
		k, aName, resName{k}, chainName, resSeq(k), X(k,1), X(k,2), X(k,3), 1, 1, atomName{k}(1));
	end
	fprintf(newFile, 'TER    %4.0f %s %s %s %3.0f\n', k, '    ', resName{k}, chainName, resSeq(k));

	fclose(newFile);
end
