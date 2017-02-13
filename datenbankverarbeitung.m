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
% Zun�chst werden die Schwellen f�r die Binarisierung berechnet.
% Anschlie�end werden diese Werte benutzt, um so das normalised structural
% image zu binarisieren.
% Abschlie�end wird das Bild noch mit einem 5mm�-Filter gegl�ttet.

[tlow, tup] = thresholds(gm, wm);
tu = num2str(tup);
tl = num2str(tlow);
spm_imcalc(ns, Vo, ['(i1<'  tu  ')&(i1>'  tl  ')'])

spm_smooth(Vo, ['s_' Vo], [5 5 5])

end

