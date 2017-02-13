function [ Vo ] = intensity_correction( Vi, Vo )
% FORMAT Vo = intensity_correction(Vi, Vo)
%
% Diese Funktion besitzt zwei Parameter. Der erste Parameter ist ein
% Bild, dessen Intensit�t korrigiert werden soll und der Zweite ist Name,
% den wir dem Outputbild geben m�chten.
% Zun�chst werden die Bilder in eine Matrix �berschrieben und anschlie�end
% die Intensit�tswerte der einzelnen Voxel korrigiert, sodass jede
% Voxelintensit�t zwischen 0 und 1 liegt.
% Zuletzt wird die Matrix wieder in ein Bild umgewandelt.

headerInfo = spm_vol(Vi);
data = spm_read_vols(headerInfo);

maximal = max(max(max(data)));

for idx = 1:numel(data)
    element = data(idx);
    if element > 0 
        data(idx) = element/maximal;
    else
        data(idx) = 0;
    end

end

headerInfo.fname = (Vo);
headerInfo.private.dat.fname = headerInfo.fname;

spm_write_vol(headerInfo, data);

end