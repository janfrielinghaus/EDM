function [tlow, tup] = thresholds( GM, WM )
% FORMAT [tlow, tup] = thresholds (GM, WM)
% 
% Bei den beiden Patametern handelt es sich um das Grey-Matter-Bild
% bzw. White-Matter-Bild.
% Mit dieser Funktion werden die beiden Schwellen berechnet, die für die
% Binarisierung benötigt werden.

gmMean = spm_summarise(GM, 'all', @mean);
gmStd = spm_summarise(GM, 'all', @std);
wmMean = spm_summarise(WM, 'all', @mean);
wmStd = spm_summarise(WM, 'all', @std);

tup = gmMean + 1/2*gmStd;
tlow = wmMean + 1/2*wmStd;

end

