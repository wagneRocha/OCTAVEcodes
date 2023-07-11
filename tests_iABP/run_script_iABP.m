arg_list   = argv ();
idCode	   = arg_list{1};
myZero	   = str2num(arg_list{2});
timeMax	   = str2num(arg_list{3});
sampleSize = str2num(arg_list{4});
numReps	   = str2num(arg_list{5});
method	   = arg_list{6};

%addpath('/home/progs/iABP/'); % CHANGE THE PATH

resFile = 'dIw_1_aIw_40';

dirname = pwd();
dataFileDir = [dirname, '/dataset/'];

for i = 1 : 10
	fnI = [dataFileDir, idCode, '/', resFile, '/I_', idCode, '_model1_chainA_ddgpHCorder', num2str(i), '.dat'];
	fnX = [dataFileDir, idCode, '/', resFile, '/X_', idCode, '_model1_chainA_ddgpHCorder', num2str(i), '.dat'];
	fnT = [dataFileDir, idCode, '/', resFile, '/T_', idCode, '_model1_chainA_ddgpHCorder', num2str(i), '.dat'];

	pre_call_method(idCode, 'A', i, myZero, timeMax, sampleSize, numReps, method, fnI, fnX, fnT)
end
