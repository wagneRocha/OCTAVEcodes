function [I, kv] = instance2adjList(I0)

	m = size(I0, 1);
	n = I0(m, 1);
	kv = zeros(n, 1);
	for i = 1 : n
		kv(i) = length(find(I0(:,1) == i));
	end

	I = zeros(n, max(kv), 3);

	I(2,1,:) = [I0(1,2), I0(1,3), I0(1,4)];

	I(3,1,:) = [I0(2,2), I0(2,3), I0(2,4)];
	I(3,2,:) = [I0(3,2), I0(3,3), I0(3,4)];

	for i = 4 : n
		vec_vi = find(I0(:,1) == i);
		for j = 1 : length(vec_vi)
				I(i,j,:) = [I0(vec_vi(j), 2), I0(vec_vi(j), 3), I0(vec_vi(j), 4)];
		end
	end
end
