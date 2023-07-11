function [ddgpParameters, X0, Iid, ku] = adjList2myFormatiBP(I, kv, T, cliques, chirality, ddgpHCorder)

	d12 = I(2, 1, 2);
	d13 = I(3, 1, 2);
	d23 = I(3, 2, 2);
	X0 = referential_x1_x2_x3(d12, d13, d23);

	n = length(kv);
	ku = zeros(n,1);

	Iid = zeros(n, max(kv)-3, 3);

	nRes = size(T,1);
	phi = T(1:2:nRes, :);
	psi = T(2:2:nRes, :);

	caso = mod(n,5);
	if(caso == 0)
		desloca = 0;
	elseif(caso == 1)
		desloca = 1;
	elseif(caso == 2)
		desloca = 2;
	else
		fprintf('ERROR\n');
	end
	switch ddgpHCorder
		case 3
			vec_N = (desloca + 6 : 5 : n);
			vec_C = [];
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = psi;
		case 4
			vec_N = (desloca + 6 : 5 : n);
			vec_C = (desloca + 9 : 5 : n);
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = T;
		case 5
			vec_N = (desloca + 6 : 5 : n);
			vec_C = [];
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = psi;
		case 6
			vec_N = (desloca + 6 : 5 : n);
			vec_C = (desloca + 9 : 5 : n);
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = T;
		case 7
			vec_N = [];
			vec_C = [];
			isPhiOrPsi = [vec_N, vec_C];
			phiOrPsi = [];
		case 8
			vec_N = [];
			vec_C = (desloca + 9 : 5 : n);
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = phi;
		case 9
			vec_N = [];
			vec_C = [];
			isPhiOrPsi = [vec_N, vec_C];
			phiOrPsi = [];
		case 10
			vec_N = [];
			vec_C = (desloca + 9 : 5 : n);
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = phi;
		case 2
			vec_N = (desloca + 6 : 5 : n);
			vec_C = (desloca + 8 : 5 : n);
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = T;
		case 1
			vec_N = (desloca + 6 : 5 : n);
			vec_C = (desloca + 8 : 5 : n);
			isPhiOrPsi = sort([vec_N, vec_C]);
			phiOrPsi = T;
	end

	w = 1;
	ddgpParameters = struct('clique', zeros(n,3), 'd24', zeros(n,1), 'd34', zeros(n,1), 'tau_positive_interval', zeros(n,2),  'tau_negative_interval', zeros(n,2));

	for v = 1 : 3
		ddgpParameters(v).clique = zeros(1,3);
		ddgpParameters(v).d24 = 0;
		ddgpParameters(v).d34 = 0;
		ddgpParameters(v).tau_positive_interval = [NaN 0];
		ddgpParameters(v).tau_negative_interval = [NaN 0];
	end
	for v = 4 : n
		check_chyrality = 0;
		if(~isempty(isPhiOrPsi))
			if(v == isPhiOrPsi(min(w, length(isPhiOrPsi))))
				check_chyrality = 1;
			end
		end

		ddgpParameters(v).clique = cliques(v,2:4);

		u1 = cliques(v,2);
		u2 = cliques(v,3);
		u3 = cliques(v,4);

		d14l = getDistanceFromI(I, v,  u3, 'l');
		d14u = getDistanceFromI(I, v,  u3, 'u');
		d24  = getDistanceFromI(I, v,  u2, 'l');
		d34  = getDistanceFromI(I, v,  u1, 'l');
		d12  = getDistanceFromI(I, u2, u3, 'l');
		d13  = getDistanceFromI(I, u1, u3, 'l');
		d23  = getDistanceFromI(I, u1, u2, 'l');

		kbar  = kappai(d12, d23, d13);
		pbar2 = rhoi2(d12, kbar);
		k     = kappai(d24, d23, d34);
		p2    = rhoi2(d24, k);

		mu = sqrt(pbar2*p2);
		nu = (k - kbar)*(k - kbar) + pbar2 + p2;

		ddgpParameters(v).d24 = d24;
		ddgpParameters(v).d34 = d34;

		absTaul = absTorsionAngleWithParameters(nu, mu, d14l);
		if(d14l == d14u)
			if(chirality(v) == 1)
				ddgpParameters(v).tau_positive_interval = [absTaul 0];
				ddgpParameters(v).tau_negative_interval = [NaN 0];
			elseif(chirality(v) == -1)
				ddgpParameters(v).tau_positive_interval = [NaN 0];
				ddgpParameters(v).tau_negative_interval = [-absTaul 0];
			else
				ddgpParameters(v).tau_positive_interval = [absTaul 0];
				ddgpParameters(v).tau_negative_interval = [-absTaul 0];
			end
		else
			absTauu = absTorsionAngleWithParameters(nu, mu, d14u);
			if(chirality(v) == 1)
				ddgpParameters(v).tau_positive_interval = [(absTauu + absTaul)/2 abs(absTauu - absTaul)/2];
				ddgpParameters(v).tau_negative_interval = [NaN 0];
			elseif(chirality(v) == -1)
				ddgpParameters(v).tau_positive_interval = [NaN 0];
				ddgpParameters(v).tau_negative_interval = [-(absTauu + absTaul)/2 abs(absTauu - absTaul)/2];
			else
				if(check_chyrality == 1)
					tauP = (phiOrPsi(w,1) + phiOrPsi(w,2));
					tauN = (phiOrPsi(w,1) - phiOrPsi(w,2));

					if(abs(tauP) > 180)
						tauP = tauP - sign(tauP)*360;
					end
					if(abs(tauN) > 180)
						tauN = tauN - sign(tauN)*360;
					end
					if((sign(tauP) == sign(tauN)) || (abs(tauN) < 0.00001) || (abs(tauP) < 0.00001))
						if((sign(tauP) > 0) || (sign(tauN) > 0))
							ddgpParameters(v).tau_positive_interval = phiOrPsi(w,:)*pi/180;
							ddgpParameters(v).tau_negative_interval = [NaN 0];
							chirality(v) = 1;
						elseif((sign(tauP) < 0) || (sign(tauN) < 0))
							ddgpParameters(v).tau_positive_interval = [NaN 0];
							ddgpParameters(v).tau_negative_interval = phiOrPsi(w,:)*pi/180;
							chirality(v) = -1;
						end
					else
						tauP = (phiOrPsi(w,1) + phiOrPsi(w,2));
						tauN = (phiOrPsi(w,1) - phiOrPsi(w,2));
						if(sign(tauP) ~= sign(tauN))
							Ineg = [min(tauP, tauN), 0]*pi/180;
							Ipos = [0, max(tauP, tauN)]*pi/180;
						elseif(tauP > 180)
							Ipos = [-180, tauP-360]*pi/180;
							Ineg = [tauN, 180]*pi/180;
						elseif(tauN < -180)
							Ipos = [tauN+360, 180]*pi/180;
							Ineg = [-180, tauP]*pi/180;
						end

						ddgpParameters(v).tau_positive_interval = [(Ipos(1) + Ipos(2))/2, abs(Ipos(1) - Ipos(2))/2];
						ddgpParameters(v).tau_negative_interval = [(Ineg(1) + Ineg(2))/2, abs(Ineg(1) - Ineg(2))/2];
					end
					w = w + 1;
				else
					ddgpParameters(v).tau_positive_interval = [(absTauu + absTaul)/2 abs(absTauu - absTaul)/2];
					ddgpParameters(v).tau_negative_interval = [-(absTauu + absTaul)/2 abs(absTauu - absTaul)/2];
				end
			end
		end

		u1_vec = double(I(v, :, 1) == u1);
		u2_vec = double(I(v, :, 1) == u2);
		u3_vec = double(I(v, :, 1) == u3);
		u1_u2_u3_vec = u1_vec + u2_vec + u3_vec;

		j = 1;
		for u = kv(v) : -1 : 1
			if((u1_u2_u3_vec(u) ~= 1) && (I(v, u, 1) ~= 0))
				if(chirality(v) ~= 0)
						Iid(v, j, :) = I(v, u, :);
						ku(v) = ku(v) + 1;
				else
					Iid(v, j, :) = I(v, u, :);
					ku(v) = ku(v) + 1;
				end
				j = j + 1;
			end
		end
	end
end
