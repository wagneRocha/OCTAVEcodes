function pre_call_method(idCode, chain, ddgpHCorder, myZero, timeMax, sampleSize, numReps, method, fnI, fnX, fnT)

    dirname = pwd();

    outputFileDir = [dirname, '/output/'];
    if(not(exist(outputFileDir, 'file')))
        mkdir(outputFileDir);
    end

    if(not(exist([outputFileDir, idCode], 'file')))
        mkdir([outputFileDir, idCode]);
    end
    call_iABP(idCode, chain, ddgpHCorder, myZero, timeMax, sampleSize, numReps, method, fnI, fnX, fnT, outputFileDir)
end