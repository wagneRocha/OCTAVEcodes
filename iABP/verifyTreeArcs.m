function isArc = verifyTreeArcs(ddgpParameters)

	n = length(ddgpParameters);
	isArc = zeros(n, 1);
	for k = 4 : n
		if(~isnan(ddgpParameters(k).tau_negative_interval(1)))
			if(ddgpParameters(k).tau_negative_interval(2) > 0)
				isArc(k) = 1;
				continue;
			end
		end
		if(~isnan(ddgpParameters(k).tau_positive_interval(1)))
			if(ddgpParameters(k).tau_positive_interval(2) > 0)
				isArc(k) = 1;
			end
		end
	end
end
