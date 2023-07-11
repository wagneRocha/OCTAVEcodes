function [rmsd, Xsol, X] = calculaRMSD(Xsol, X)
    
	n = size(X,1);
    
	[Xsol, X] = mesmoCentrodeMassa(Xsol, X);
	Q = melhorRotacaoNormaF(Xsol, X);
	Xsol = Xsol*Q';
	
	rmsd = norm(X - Xsol,'fro')/sqrt(n);
end
