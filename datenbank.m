% Dieses Skript dient dazu, über die Funktion zu iterieren und so jedes
% einzelne Bild der Datenbank zu verarbeiten.
% Um die richtigen Bilder für die einzelnen Listen auszuwählen, wird in dem
% Befehl spm_select der passende Präfix ausgewählt, um so die richtigen
% Bilder zu filtern.
% Der Parameter 'List' kann so übernommen werden. 
% pwd bedeutet, dass ausgewählten Verzeichnis nach den Bildern gesucht
% wird. Wenn man woanders nach den Bildern suchen möchte, muss der gesamte
% Pfad angegeben werden.


data_gm = spm_select('List', pwd, '^w_c1.*\.nii$');
data_wm = spm_select('List', pwd, '^w_c2.*\.nii$');
data_ns = spm_select('List', pwd, '^result.*\.nii$');

for i = 1:1:48
    datenbankverarbeitung(data_gm(i,:), data_wm(i,:), data_ns(i,:), ['binary' num2str(i) '.nii']);
end