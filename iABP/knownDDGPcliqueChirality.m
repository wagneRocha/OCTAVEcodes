function vecChirality = knownDDGPcliqueChirality(ddgpHCorder, n)

	vecChirality = ones(n,1);
	
	caso = mod(n,5);
	if(caso == 0)
		% there are no H3 and H2
		% AtomsOrder = {'H', 'N', 'CA', 'HA', 'C'};
		vecChirality(4) = 0;
		desloca = 0;
	elseif(caso == 1)
		% there is H2 or H3
		% AtomsOrder = {'H2', 'H', 'N', 'CA', 'HA', 'C'};
		vecChirality(5) = 0;
		desloca = 1;
	elseif(caso == 2)
		% there are H2 and H3
		% AtomsOrder = {'H3', 'H2', 'H', 'N', 'CA', 'HA', 'C'};
		vecChirality(6) = 0;
		desloca = 2;
	else
		fprintf('ERRO\n');
	end
	
	switch ddgpHCorder
		%%
		case 3
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, HZi, HAi, Ci
			%			...,
			%			Np, CAp, HZp, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_N  = (desloca + 6 : 5 : n);
			vec_HA = (desloca + 9 : 5 : n);
			vec_0  = [vec_N, vec_HA];

			vecChirality(vec_0) = 0;
		%%
		case 4
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, HZi, Ci, HAi
			%			...,
			%			Np, CAp, HZp, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_N  = (desloca + 6 : 5 : n);
			vec_C  = (desloca + 9 : 5 : n);
			vec_0  = [vec_N, vec_C];

			vecChirality(vec_0) = 0;
		%%	
		case 5
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, HZi, CAi, HAi, Ci
			%			...,
			%			Np, HZp, CAp, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_N  = (desloca + 6 : 5 : n);
			vec_HA = (desloca + 9 : 5 : n);
			vec_0  = [vec_N, vec_HA];

			vecChirality(vec_0) = 0;
		%%
		case 6
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, HZi, CAi, Ci, HAi
			%			...,
			%			Np, HZp, CAp, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_N  = (desloca + 6 : 5 : n);
			vec_C  = (desloca + 9 : 5 : n);
			vec_0  = [vec_N, vec_C];
			
			vecChirality(vec_0) = 0;
		%%
		case 7
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, Ni, CAi, HAi, Ci
			%			...,
			%			HZp, Np, CAp, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_H  = (desloca + 6 : 5 : n);
			vec_HA = (desloca + 9 : 5 : n);
			vec_0  = [vec_H, vec_HA];

			vecChirality(vec_0) = 0;
		%%
		case 8
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, Ni, CAi, Ci, HAi
			%			...,
			%			HZp, Np, CAp, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_H  = (desloca + 6 : 5 : n);
			vec_C  = (desloca + 9 : 5 : n);
			vec_0  = [vec_H, vec_C];

			vecChirality(vec_0) = 0;
		%%
		case 9
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, CAi, Ni, HAi, Ci
			%			...,
			%			HZp, CAp, Np, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_H  = (desloca + 6 : 5 : n);
			vec_HA = (desloca + 9 : 5 : n);
			vec_0  = [vec_H, vec_HA];

			vecChirality(vec_0) = 0;
		%%
		case 10
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, CAi, Ni, Ci, HAi
			%			...,
			%			HZp, CAp, Np, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_H  = (desloca + 6 : 5 : n);
			vec_C  = (desloca + 9 : 5 : n);
			vec_0  = [vec_H, vec_C];

			vecChirality(vec_0) = 0;
		%%
		case 2
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, Ci, HAi, HZi
			%			...,
			%			Np, CAp, Cp, HAp, HZp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_N  = (desloca + 6 : 5 : n);
			vec_C  = (desloca + 8 : 5 : n);
			vec_0  = [vec_N, vec_C];

			vecChirality(vec_0) = 0;
		%%
		case 1
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, Ci, HZi, HAi
			%			...,
			%			Np, CAp, Cp, HZp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			vec_N  = (desloca + 6 : 5 : n);
			vec_C  = (desloca + 8 : 5 : n);
			vec_0  = [vec_N, vec_C];

			vecChirality(vec_0) = 0;
		%%
	end
end
