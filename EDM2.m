function Vo = EDM2(Vi, Vo)
%FORMAT Vo = MAP2(Vi, Vo)
%   Vor dem Ausf�hren dieses Skriptes durchl�uft das Bild des kranken
%   Patienten zwei Vorverarbeitungsschritte. Zun�chst wird das Bild
%   Gewebeklassen Grey Matter, White Matter und CSF segmentiert.
%   Anschlie�end werden die Bilder auf MNI-Space normalisiert.

%   Nachdem die Vorverarbeitung abgeschlossen ist, werden die folgenden
%   Bildverarbeitungsschritte durchgef�hrt. Zun�chst wird das Bild mit
%   einem Filter von 6mm Voxelkantenl�nge gegl�ttet(spm_smooth).
%   Anschlie�end subtrahiert man von dem gegl�tteten Bild das
%   Mittelwertsbild der Normdatenbank (spm_imcalc).
%   Im letzten Schritt wird das aus der Subtraktion resultierende Bild mit
%   dem Standardabweichungsbild der Normdatenbank dividiert (spm_imcalc). 
%   Das daraus entstehende Bild ist das Ergebnis.

%Checking parameters
%==========================================================================

if nargin < 2
    error('Error: Nicht genug Paramater')
end

%Input Image
%==========================================================================

if ~isstruct(Vi), Vi = spm_vol(char(Vi)); end

if isempty(Vi), error('no input images specified.'), end

if isstruct(Vo)
    Vchk   = spm_cat_struct(Vo,Vi);
    refstr = 'output';
else
    Vchk   = Vi(:);
    refstr = '1st';
end
[sts, str] = spm_check_orientations(Vchk, false);
if ~sts
    for i=1:size(str,1)
        fprintf('Warning: %s - using %s image.\n',strtrim(str(i,:)),refstr);
    end
end

%Ausf�hrung der Bildverarbeitungsschritte
%==========================================================================

spm_smooth(Vi, Vo , [6 6 6]);

spm_imcalc_ui({Vo; 'C:/Users/Jan/Desktop/Praktikum_Lippstadt/Praktikum_Pr�sentation/Ingenia/Datenbank/c1_Grey_Matter/s_meanImage.nii'}, Vo, 'i1-i2');

spm_imcalc_ui({Vo; 'C:/Users/Jan/Desktop/Praktikum_Lippstadt/Praktikum_Pr�sentation/Ingenia/Datenbank/c1_Grey_Matter/s_stdImage.nii'}, Vo, 'i1%i2')
