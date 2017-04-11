"websnap" ist ein Tool mit dess Hilfe Screenshots von beliebigen Webseiten in beliebigen Intervallen aufgenommen werden können. Täglich kann dann zu einer gewählten Uhrzeit ein Video aus diesen Screenshots generiert werden, wobei auf hier nur gewisse Screenshots ausgewählt werden können.

Zur Ausführung von "websnap" sind the folgenden Linux-Tools notwendig:
	
	sudo apt install npm
	sudo apt install nodejs-legacy
	sudo npm install --global pageres-cli
	sudo apt-get install imagemagick imagemagick-doc
	sudo apt-get install ffmpeg

Von nun an kann "websnap" mit dem Kommandozeilenaufruf 

	bash websnap.sh settings.txt

gestartet werden.

Das Skript erwartet eine Einstellungsdatei in den Argumenten. Eine solche Datei liegt im Git (https://github.com/pdowideit/websnap) dem Bash Skript bei. Die Syntax in dieser Datei lautet:

PATH: Der Name des Ordners unter dem die Ordnerstruktur (days, films, log, montages) erstellt wird. Lautet PATH zum Beispiel "data" und die Skriptdatei unter "~/" so wird ein Ordner unter "~/data" erstellt, der die Dateien beinhaltet.
URLS: Sind die URLS der Webseiten von denen Screenshots gemacht werden sollen. Hier kann ebenfalls die Bearbeitung der Screenshots eingestellt werden: URL>HÖHExBREITE+VERSCHIEBUNGHORIZONTAL+VERSCHIEBUNGVERTIKAL
TIME: Ist die Uhrzeit zu der täglich automatisch ein Film der Screenshots (bei FILM einstellbar) des letzten Tages generiert wird. Wichig zu beachten is, wenn 9 Uhr die gewählte Uhrzeit ist sollte hier 09 eingetragen werden.
INTERVALL: Ist das Intervall (in Minuten) in dem Screenshots gemacht werden. Hier sollten keine zu geringen Zahlen gewählt werden, da ansonsten das System überlastet wird. Die geringste empfohlene Zahl ist 5.
FILM: Sind the Indizees der URLS die im generierten Film verwendet werden sollen. Der Erste Index ist hierbei 0. Sollten Sie alle URLS verwenden wollen müssen alle Indizees angegeben werden.
DURATION: Ist die Anzeigedauer eines einzelnen Intervalls in Sekunden im Film. 

Damit "websnap" nun regelmäßig aufgerufen wird, wird ein "crontab" verwendet, der vom Benutzer eingerichtet werden muss. Dazu rufen Sie "crontab -e" auf und kopieren die folgenden Zeilen in die Datei:
	
	SHELL=/bin/bash
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin
	* * * * * bash YOURWEBSNAPPATH/websnap.sh YOURSETTINGSPATH/settings.txt

Nun ist die Anwendung fertig konfiguriert und nimmt im, von Ihnen gewünschten Intervall, Screenshots der gewählten Webseiten auf.



Autor: Paul Dowideit
