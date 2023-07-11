function [X, imax, numIt] = iABP(X, n, ddgpParameters, Iid, ku, isArc, sampleSize, myZero, timeMax)
	
	A = zeros(n,3);
	B = A;
	C = A;
	numIt = 0;

	branches = NaN(n, 2*sampleSize);
	exploredVertex = zeros(n,1);
	branchNum = ones(n,1);

	i = 4;
	imax = 3;
	iniTime = clock;
	while((i <= n) && (etime(clock, iniTime) < timeMax))
	% fprintf('iABP: ----------------- layer %d ----------------- \n', i);
		if(exploredVertex(i) == 0)
			clear T
			ng = 1;
			if(not(isnan(ddgpParameters(i).tau_positive_interval(1))))
				T(ng).m	 = ddgpParameters(i).tau_positive_interval(1);
				T(ng).delta = ddgpParameters(i).tau_positive_interval(2);
				ng = ng + 1;
			end
			if(not(isnan(ddgpParameters(i).tau_negative_interval(1))))
				T(ng).m	 = ddgpParameters(i).tau_negative_interval(1);
				T(ng).delta = ddgpParameters(i).tau_negative_interval(2);
			end
			
			u1 = X(ddgpParameters(i).clique(1), :);
			u2 = X(ddgpParameters(i).clique(2), :);
			u3 = X(ddgpParameters(i).clique(3), :);
			if((ku(i) > 0) && (isArc(i)))
				% jn < jn-1 < ... < j4
				Jn = Iid(i, 1 : ku(i), 1);
				for k = 1 : ku(i)
					uk	 = X(Jn(k), :);
					dukuil = Iid(i, k, 2);
					dukuiu = Iid(i, k, 3);
					
					phasek = torsionAngleWithPoints(u3, u2, u1, uk);
					tauKl = absTorsionAngleWithPointsAndDistances(uk, u2, u1, dukuil, ddgpParameters(i).d24, ddgpParameters(i).d34);
					tauKu = absTorsionAngleWithPointsAndDistances(uk, u2, u1, dukuiu, ddgpParameters(i).d24, ddgpParameters(i).d34);

					if(((tauKl == pi) && (tauKu == pi)) || ((tauKl == 0) && (tauKu == 0)))
						T = [];
						break;
					end
					
					Tau1pk.m = (tauKu + tauKl)/2;
					Tau1pk.delta  = abs(tauKu - tauKl)/2;

					Tau1nk = Tau1pk;
					Tau1nk.m = -Tau1nk.m;

					clear Tk
					Tk(1) = changeReferentialTau0(phasek, Tau1pk);
					Tk(2) = changeReferentialTau0(phasek, Tau1nk);

					T = interIntervalS(T, Tk, myZero);
				end
			end

			if(~isempty(T))
				[branches(i,:), branchNum(i)] = sampleInterval(T, isArc(i), sampleSize, myZero);
				
				exploredVertex(i) = 1;
				[A(i,:), B(i,:), C(i,:)] = cirfunferenceParameters(u3, u2, u1, ddgpParameters(i));
			else
				% backtracking in the tree
				[i, exploredVertex, branches, branchNum] = backtrackingNaArvore(i, exploredVertex, branches, branchNum, 2*sampleSize);
				if(i == 3)
					% fprintf('ibp: ERROR! I did not find the instance solution\n');
					break;
				end
				continue;
			end
		else
			branches(i, branchNum(i)) = NaN;
			branchNum(i) = branchNum(i) + 1;
		end

		if(branchNum(i) <= 2*sampleSize)
			tau = branches(i, branchNum(i));
			X(i,:) = A(i,:) + B(i,:)*cos(tau) + C(i,:)*sin(tau);
			numIt = numIt + 1;

			flagSatisfiesExtraDistances = 1;
			if((ku(i) > 0) && (not(isArc(i))))
				Jn = Iid(i, 1 : ku(i), 1);
				for k = 1 : ku(i)
					dukuil = roundoct(Iid(i, k, 2), 4);
					dukuiu = roundoct(Iid(i, k, 3), 4);
					duiuk  = roundoct(norm(X(i,:) - X(Jn(k),:)), 4);
					if((duiuk < dukuil) || (duiuk > dukuiu))
						flagSatisfiesExtraDistances = 0;
						break;
					end
				end
			end

			if(flagSatisfiesExtraDistances)
				i = i + 1;
				if(imax < i)
					imax = i;
				end
				continue;
			else
				% backtracking in the tree
				[i, exploredVertex, branches, branchNum] = backtrackingNaArvore(i, exploredVertex, branches, branchNum, 2*sampleSize);
				if(i == 3)
					% fprintf('ibp: ERROR! I did not find the instance solution\n');
					break;
				end
			end
		else
			% backtracking in the tree
			[i, exploredVertex, branches, branchNum] = backtrackingNaArvore(i, exploredVertex, branches, branchNum, 2*sampleSize);
			if(i == 3)
				% fprintf('ibp: ERROR! I did not find the instance solution\n');
				break;
			end
		end
	end
	if(i <= n)
		X = [];
	end
end
