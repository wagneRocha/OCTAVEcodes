function d = getDistanceFromI(I, v1,  v2, opt)
	
	v2pos = find(I(v1, :, 1) == v2);
	if(not(isempty(v2pos)))
		u1 = v1;
		u2pos = v2pos;
	else
		u1 = v2;
		u2pos = find(I(v2, :, 1) == v1);
	end

	if(strcmp(opt,'l'))
		d = I(u1, u2pos, 2);
	else
		d = I(u1, u2pos, 3);
	end
end
