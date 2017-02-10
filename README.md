# EDM 

Epilepsy Diagnostic Machine, kurz EDM, ist ein Programm zur Detektierung von Anomalien im Gehirn, die auf Epilepsie hindeuten. Auf Basis dieses Verfahrens kann der Arzt eine Diagnose stellen.

Die Skripte nutzen die Bildverarbeitungsschritte, die im Artikel [Morphometric MRI Analysis](https://books.google.de/books?id=hWZHAAAAQBAJ&pg=PA76&lpg=PA76&dq=normal+databank+of+junction+images&source=bl&ots=pPdNj9g_N7&sig=l4bSRIAFAuZKjQtNdj71yJDBFKk&hl=en&sa=X&ved=0ahUKEwi93oX-woXSAhVpM5oKHU5uBJEQ6AEIPTAO#v=onepage&q=normal%20databank%20of%20junction%20images&f=false) des Buches _MRI in Epilepsy_ beschrieben werden. Dort sind drei verschiedene Wege beschrieben um ans Ziel zu gelangen.

Ich stelle in diesem Projekt die ersten beiden Wege vor.

## Anforderungen

* [SPM Toolkit](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)

* Matlab (Version 7.4 bis 9.1)

* Datenbank
  * 50 - 100 MR-Datensätze von gesunden Probanden
  * Scanner-spezifisch
  * T1-Sequenz

* Matlab-Skripte

## Worauf ist zu achten...

* SPM in Matlab einbinden 
	* `addpath C:/spm/spm12` eintippen

* SPM starten 
	* `spm` eintippen

* Skripte in den Spm12-Ordner verschieben

* in Matlab die richtige **Working directory** angeben bzw.

* den gesamten Dateipfad des benötigten Bildes eingeben

## Einführung

Die SPM-Software nutzt für die Bildverarbeitung ein Nifti-Format. Mit dem Toolkit ist es möglich
DICOM-Dateien zu importieren und diese anschließend in eine Nifti-Datei umzuwandeln.

Für die Bildanalyse ist es notwendig zwei Vorverarbeitungsschritte durchzuführen, sowohl für die Testbilder
als auch die Datenbankbilder. Und zwar die Bildsegmentierung und -normalisierung.

## Bearbeitung der Datenbank

Nach der Segmentierung und Normalisierung der Datenbankbilder müssen zunächst die resultierenden Bilder mit dem Präfix _'w_m'_ mithilfe des Skriptes
**intensity_correction** bearbeitet werden. Ist dieser Schritt erledigt, lässt man das Skript **datenbank** mit allen passenden Parametern laufen.
Anschließend sollte die Datenbank soweit bearbeitet sein, dass man das Mittelwerts und Standardabweichungsbild erzeugen kann.

Dies funktioniert für das Mittelwertsbild mit 

	* `spm_imcalc(spm_select('List', directory, '^präfix.*\.nii$'), 'Mean(X)', {1;0;4;0})

Dies funktioniert für das Standardabweichungsbild mit

	* `spm_imcalc(spm_select('List', directory, '^präfix.*\.nii$'), 'Std(X)', {1;0;4;0})
	
Diese Schritte sind nötig, um den ersten, im Artikel beschriebenen, Weg durchzuführen.

Für den zweiten Weg werden nur die Grey-Matter-Bilder benötigt. Aus diesen Bilder wird auch ein Mittelwerts- und Standardabweichungsbild erzeugt

Dafür nutzt man

	* `spm_imcalc(spm_select('List', directory, '^präfix.*\.nii$'), 'Mean(X)', {1;0;4;0})
	
und

	*  `spm_imcalc(spm_select('List', directory, '^präfix.*\.nii$'), 'Std(X)', {1;0;4;0})
	
Abschließend werden die beiden Bilder mit einem 6mm³ Filter geglättet.	


## Durchführung

Nun muss man den Skriptnamen mit den passenden Parametern im Command Window eingeben und schon läuft das Skript.

## Copyright

Copyright (c) 2017 Jan Frielinghaus
