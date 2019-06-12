# systemd-init
	Az álltalam készített systemd alatt működő szolgáltatásaim és azok kezelése.
	Azét van "voli-" előtag, hogy még véletlenül se keveredjenek az alap service-kel és egy helyen legyenek.

##	Beallito
		Egységes script segítségével: 
		    1:	Tiltom a régi initscrip-eket
		    2:	Tiltom a nem szükséges systemd service-ket
		    3:	Bemásolom (hard link) és beállítom az én service-eimet


---------------------------
A hibás függőségeket jeleníti meg grafikussan; jellemzően üres kimenetet ad, elvére ilyen nem lehet

systemd-analyze verify default.target |perl -lne 'print $1 if m{Found.*?on\s+([^/]+)}' | xargs --no-run-if-empty systemd-analyze dot | dot -Tsvg >cycle.svg


##	voli-irexec.service, voli-lirc.service
		Kellenek a távirányítóhoz tiltja a lirc-et

##	voli-rc, voli-rc.service
		Induláskor ezeket kell beállítani
