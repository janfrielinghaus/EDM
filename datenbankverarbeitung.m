function [ Vo ] = datenbankverarbeitung( gm, wm, ns, Vo)
% FORMAT Vo = datenbankvereinbarung(gm, wm, ns, Vo)
% 
% Parameter
%==========================================================================
% gm    Grey Matter
% wm    White Matter
% ns    normalised structural Image
% Vo    Output Image
%
% Zunächst werden die Schwellen für die Binarisierung berechnet.
% Anschließend werden diese Werte benutzt, um so das normalised structural
% image zu binarisieren.
% Abschließend wird das Bild noch mit einem 5mm³-Filter geglättet.

[tlow, tup] = thresholds(gm, wm);
tu = num2str(tup);
tl = num2str(tlow);
spm_imcalc(ns, Vo, ['(i1<'  tu  ')&(i1>'  tl  ')'])

spm_smooth(Vo, ['s_' Vo], [5 5 5])

end

