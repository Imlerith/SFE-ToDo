% % Example Call
% % Plaese first save the file on your current workingdirectory and then use the xample call
% index     = 37.2416;
% recoveryR = 0.4;                            % Recovery rate
% UAP       = [0.03, 0.06, 0.09, 0.12, 0.22]; % Upper attachment points
% lam       = index / 10000 / (1 - recoveryR);
% tr        = 1;
% defProb   = 1 - exp(-lam);                  % Default probability
% rho       = 0.01:0.01:0.99;                 % compound correlation
% a         = sqrt(rho);                      % square-root of compound correlation
% etl       = NaN;
% for i = 1:length(a)
%     etl(i) = ETL(a(i), recoveryR, defProb, UAP(tr));
% end
% etl

function EL = ETL(a, R, defProb, UAP)
    C     = norminv(defProb, 0, 1);
    NinvK = norminv(UAP / (1 - R), 0, 1);
    A     = (C - sqrt(1 - a^2) * NinvK) / a;
    Sigma = [1 -a; -a 1];
    Mu    = [0 0];
    EL1   = mvncdf([C, -A], Mu, Sigma);
    EL2   = normcdf(A);
    EL    = EL1 / UAP * (1 - R) + EL2;
end