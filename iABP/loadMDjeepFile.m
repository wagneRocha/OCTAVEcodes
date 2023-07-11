function [I, resSeq, resName, AtomsOrder] = loadMDjeepFile(MDjeepFile)
	MD_data = importdata(MDjeepFile);
	
	vecTab = find(MD_data{1} == '	');
	
	nlin = length(MD_data);
	n    = str2double(MD_data{nlin}(1 : vecTab(1)));
	
	I = zeros(nlin, 4);
	resSeq = zeros(n,1);
	
	resSeq(1)	= str2double(MD_data{1}(vecTab(3)+1 : vecTab(4)-1));
	resName{1,1}	= strrep(MD_data{1}(vecTab(9)+1 : end),' ','');
	AtomsOrder{1,1} = strrep(MD_data{1}(vecTab(7)+1 : vecTab(8)-1),' ','');
	
	i = 2;
	for k = 1 : nlin
		vecTab = find(MD_data{k} == '	');
		I(k,1) = str2double(MD_data{k}(1 : vecTab(1)));
		I(k,2) = str2double(MD_data{k}(vecTab(1)+1 : vecTab(2)-1));
		I(k,3) = str2double(MD_data{k}(vecTab(4)+1 : vecTab(5)-1));
		I(k,4) = str2double(MD_data{k}(vecTab(5)+1 : vecTab(6)-1));
		
		curAtom = I(k,1);
		if(curAtom == i)
			resSeq(i)	= str2double(MD_data{k}(vecTab(2)+1 : vecTab(3)-1));
			resName{i,1}	= strrep(MD_data{k}(vecTab(8)+1 : vecTab(9)-1),' ','');
			AtomsOrder{i,1} = strrep(MD_data{k}(vecTab(6)+1 : vecTab(7)-1),' ','');
			i = i + 1;
		end
	end
end
