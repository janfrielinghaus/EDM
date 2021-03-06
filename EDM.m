function Vo = EDM(Vi, Vo)
%FORMAT Vo = MAP(Vi, Vo)
%   Vor dem Ausführen dieses Skriptes durchläuft das Bild des kranken
%   Patienten zwei Vorverarbeitungsschritte. Zunächst wird das Bild
%   Gewebeklassen Grey Matter, White Matter und CSF segmentiert.
%   Anschließend werden die Bilder auf MNI-Space normalisiert.

%   Nachdem die Vorverarbeitung abgeschlossen ist, werden die folgenden
%   Bildverarbeitungsschritte durchgeführt. Zunächst wird das Bild mit
%   einem Filter von 5mm Voxelkantenlänge geglättet(spm_smooth).
%   Anschließend subtrahiert man von dem geglätteten Bild das
%   Mittelwertsbild der Normdatenbank (spm_imcalc).
%   Im letzten Schritt wird das aus der Subtraktion resultierende Bild mit
%   dem Standardabweichungsbild der Normdatenbank dividiert (spm_imcalc). 
%   Das daraus entstehende Bild ist das Ergebnis.

%Checking Parameters
%==========================================================================
if nargin < 2
    error('ERROR: Nicht genug Parameter')
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

%Ausführung der Bildverarbeitungsschritte
%==========================================================================
spm_smooth(Vi, Vo, [5 5 5])

spm_imcalc({Vo; 'C:/Users/Jan/Desktop/Praktikum_Lippstadt/Praktikum_Präsentation/Ingenia/Datenbank/Neuer Ordner/meanDatenbank.nii'}, Vo, 'i1-i2')

spm_imcalc({Vo; 'C:/Users/Jan/Desktop/Praktikum_Lippstadt/Praktikum_Präsentation/Ingenia/Datenbank/Neuer Ordner/stdDatenbank.nii'}, Vo, 'i1%i2')

end

