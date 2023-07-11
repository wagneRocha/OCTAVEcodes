function cliques = DDGPcliques(ddgpHCorder, n)

	caso = mod(n,5);
	if(caso == 0)
		% there are no H3 and H2
		desloca = 2;
	elseif(caso == 1)
		% there is H2 or H3
		desloca = 1;
	elseif(caso == 2)
		% there are H2 and H3
		desloca = 0;
	else
		fprintf('ERRO\n');
	end

	cliques = zeros(n,4);

	cliqueR1 = zeros(7-desloca,4);
	if(caso == 0)
		for i = 1 : 4
			cliqueR1(i,:) = [max(i,0), max(i-1,0), max(i-2,0), max(i-3,0)];
		end
		cliqueR1(5,:) = [5, 1, 2, 4];
	else
		for i = 1 : 7-desloca
			cliqueR1(i,:) = [max(i,0), max(i-1,0), max(i-2,0), max(i-3,0)];
		end
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
			if(caso == 0)
				cliquesR2 = [ 	6, 3, 2, 1
						7, 6, 3, 2
						8, 7, 6, 3
						9, 7, 6, 8
						10, 9, 7, 6];
			else
				cliquesR2 = [ 	8, 7, 5, 4
						9, 8, 7, 5
						10, 9, 8, 7
						11, 9, 8, 10
						12, 11, 9, 8]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % N
						cliques(i,:) = [i, i-1, i-4, i-5];
					case 2 % CA
						cliques(i,:) = [i, i-1, i-2, i-5];
					case 3 % HZ
						cliques(i,:) = [i, i-1, i-2, i-3];
					case 4 % HA
						cliques(i,:) = [i, i-2, i-3, i-1];
					case 0 % C
						cliques(i,:) = [i, i-1, i-3, i-4];
				end
			end
		%%
		case 4
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, HZi, Ci, HAi
			%			...,
			%			Np, CAp, HZp, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [ 	6, 3, 2, 1
						7, 6, 3, 2
						8, 7, 6, 3
						9, 7, 6, 3
						10, 9, 7, 6];
			else
				cliquesR2 = [ 	8, 7, 5, 4
						9, 8, 7, 5
						10, 9, 8, 7
						11, 9, 8, 7
						12, 11, 9, 8]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % N
						cliques(i,:) = [i, i-2, i-4, i-5];
					case 2 % CA
						cliques(i,:) = [i, i-1, i-3, i-5];
					case 3 % HZ
						cliques(i,:) = [i, i-1, i-2, i-4];
					case 4 % C
						cliques(i,:) = [i, i-2, i-3, i-5];
					case 0 % HA
						cliques(i,:) = [i, i-1, i-3, i-4];
				end
			end
		%%	
		case 5
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, HZi, CAi, HAi, Ci
			%			...,
			%			Np, HZp, CAp, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0) % OK
				cliquesR2 = [ 	6, 3, 2, 1
						7, 6, 3, 2
						8, 6, 3, 2
						9, 8, 6, 7
						10, 9, 8, 6];
			else
				cliquesR2 = [	8, 7, 5, 4
						9, 8, 7, 5
						10, 8, 7, 5
						11, 10, 8, 9
						12, 11, 10, 8]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % N
						cliques(i,:) = [i, i-1, i-3, i-5];
					case 2 % HZ
						cliques(i,:) = [i, i-1, i-2, i-4];
					case 3 % CA
						cliques(i,:) = [i, i-2, i-3, i-5];
					case 4 % HA
						cliques(i,:) = [i, i-1, i-3, i-2];
					case 0 % C
						cliques(i,:) = [i, i-1, i-2, i-4];
				end
			end
		%%
		case 6
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, HZi, CAi, Ci, HAi
			%			...,
			%			Np, HZp, CAp, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0) % OK
				cliquesR2 = [	6, 3, 2, 1
						7, 6, 3, 2
						8, 6, 3, 2
						9, 8, 6, 3
						10, 9, 8, 6];
			else
				cliquesR2 = [	8, 7, 5, 4
						9, 8, 7, 5
						10, 8, 7, 5
						11, 10, 8, 7
						12, 11, 10, 8]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % N
						cliques(i,:) = [i, i-2, i-3, i-5];
					case 2 % HZ
						cliques(i,:) = [i, i-1, i-3, i-4];
					case 3 % CA
						cliques(i,:) = [i, i-2, i-4, i-5];
					case 4 % C
						cliques(i,:) = [i, i-1, i-3, i-5];
					case 0 % HA
						cliques(i,:) = [i, i-1, i-2, i-4];
				end
			end
		%%
		case 7
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, Ni, CAi, HAi, Ci
			%			...,
			%			HZp, Np, CAp, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [	6, 3, 2, 4
						7, 6, 3, 2
						8, 7, 3, 2
						9, 8, 7, 6
						10, 9, 8, 7];
			else
				cliquesR2 = [	8, 7, 5, 6
						9, 8, 7, 5
						10, 9, 7, 5
						11, 10, 9, 8
						12, 11, 10, 9]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % HZ
						cliques(i,:) = [i, i-1, i-3, i-2];
					case 2 % N
						cliques(i,:) = [i, i-1, i-2, i-4];
					case 3 % CA
						cliques(i,:) = [i, i-1, i-3, i-5];
					case 4 % HA
						cliques(i,:) = [i, i-1, i-2, i-3];
					case 0 % C
						cliques(i,:) = [i, i-1, i-2, i-3];
				end
			end
		%%
		case 8
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, Ni, CAi, Ci, HAi
			%			...,
			%			HZp, Np, CAp, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [	6, 3, 2, 4
						7, 6, 3, 2
						8, 7, 3, 2
						9, 8, 7, 6
						10, 9, 8, 7];
			else
				cliquesR2 = [	8, 7, 5, 6
						9, 8, 7, 5
						10, 9, 7, 5
						11, 10, 9, 7
						12, 11, 10, 9]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % HZ
						cliques(i,:) = [i, i-2, i-3, i-1];
					case 2 % N
						cliques(i,:) = [i, i-1, i-3, i-4];
					case 3 % CA
						cliques(i,:) = [i, i-1, i-4, i-5];
					case 4 % C
						cliques(i,:) = [i, i-1, i-2, i-5];
					case 0 % HA
						cliques(i,:) = [i, i-1, i-2, i-3];
				end
			end
		%%
		case 9
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, CAi, Ni, HAi, Ci
			%			...,
			%			HZp, CAp, Np, HAp, Cp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [	6, 3, 2, 4
						7, 6, 3, 2
						8, 7, 6, 3
						9, 7, 8, 6
						10, 9, 7, 8];
			else
				cliquesR2 = [	8, 7, 5, 6
						9, 8, 7, 5
						10, 9, 8, 7
						11, 9, 10, 8
						12, 11, 9, 10]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % HZ
						cliques(i,:) = [i, i-1, i-4, i-2];
					case 2 % CA
						cliques(i,:) = [i, i-1, i-2, i-5];
					case 3 % N
						cliques(i,:) = [i, i-1, i-2, i-3];
					case 4 % HA
						cliques(i,:) = [i, i-2, i-1, i-3];
					case 0 % C
						cliques(i,:) = [i, i-1, i-3, i-2];
				end
			end
		%%
		case 10
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			HZi, CAi, Ni, Ci, HAi
			%			...,
			%			HZp, CAp, Np, Cp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [	6, 3, 2, 4
						7, 6, 3, 2
						8, 7, 6, 3
						9, 7, 8, 3
						10, 9, 7, 8];
			else
				cliquesR2 = [	8, 7, 5, 6
						9, 8, 7, 5
						10, 9, 8, 7
						11, 9, 10, 7
						12, 11, 9, 10]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % HZ
						cliques(i,:) = [i, i-2, i-4, i-1];
					case 2 % CA
						cliques(i,:) = [i, i-1, i-3, i-5];
					case 3 % N
						cliques(i,:) = [i, i-1, i-2, i-4];
					case 4 % C
						cliques(i,:) = [i, i-2, i-1, i-5];
					case 0 % HA
						cliques(i,:) = [i, i-1, i-3, i-2];
				end
			end
		%%
		case 2
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, Ci, HAi, HZi
			%			...,
			%			Np, CAp, Cp, HAp, HZp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [	6, 3, 2, 1
						7, 6, 3, 2
						8, 7, 6, 3
						9, 8, 7, 6
						10, 7, 6, 3];
			else
				cliquesR2 = [	8, 7, 5, 4
						9, 8, 7, 5
						10, 9, 8, 7
						11, 10, 9, 8
						12, 9, 8, 7]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % N
						cliques(i,:) = [i, i-3, i-4, i-5];
					case 2 % CA
						cliques(i,:) = [i, i-1, i-4, i-5];
					case 3 % C
						cliques(i,:) = [i, i-1, i-2, i-5];
					case 4 % HA
						cliques(i,:) = [i, i-1, i-2, i-3];
					case 0 % HZ
						cliques(i,:) = [i, i-3, i-4, i-7];
				end
			end
		%%
		case 1
			% DDGP hc Order: {	H3, H2, H1, N1, CA1, HA1, C1, // N1, CA1, C1, HA1, H1, 
			%			...,
			%			Ni, CAi, Ci, HZi, HAi
			%			...,
			%			Np, CAp, Cp, HZp, HAp}
			% -------------------- 2nd to p-th Residue --------------------
			if(caso == 0)
				cliquesR2 = [	6, 3, 2, 1
						7, 6, 3, 2
						8, 7, 6, 3
						9, 7, 6, 3
						10, 8, 7, 6];
			else
				cliquesR2 = [	8, 7, 5, 4
						9, 8, 7, 5
						10, 9, 8, 7
						11, 9, 8, 7
						12, 10, 9, 8]-desloca;
			end
			
			cliques(1:12-desloca,:) = [cliqueR1; cliquesR2];
			
			for i = 13-desloca : n
				switch mod(i-(12-desloca),5)
					case 1 % N
						cliques(i,:) = [i, i-3, i-4, i-5];
					case 2 % CA
						cliques(i,:) = [i, i-1, i-4, i-5];
					case 3 % C
						cliques(i,:) = [i, i-1, i-2, i-5];
					case 4 % HZ
						cliques(i,:) = [i, i-2, i-3, i-6];
					case 0 % HA
						cliques(i,:) = [i, i-2, i-3, i-4];
				end
			end
		%%
	end
end
