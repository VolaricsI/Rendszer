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


##	edit-mythtv-backend.service.sh
		A mythtv-backend service-nek kell a mysql service

##	edit-docker.service.sh
		A docker.service-nek kell hogy a /var/lib/docker egy csatolási pont legyen,
		így minden adata külön volume-ra kerül

##	edit-voli-openvpn.sh
		Az openvpn@service mindíg induljon újra

##	voli-mythtv-switch.service
		A MythTV fronted-jét (megjelenítő/TV)  ki/be kapcsolgatja, jellemzően a távirányító használja

##	voli-irexec.service, voli-lirc.service
		Kellenek a távirányítóhoz tiltja a lirc-et

##	voli-rc, voli-rc.service
		Induláskor ezeket kell beállítani

##	voli-openvpn-starter.service
		Minden OpenVPN configra indít egy service-t, a gyári Unit-ot amiben modosítottam:
			[Service]
			    RestartSec=30
			    Restart=always
		Illetve az voli-openvpn-edit script ezt végleg legyártja

##	voli-fetchmail-user.service
		A Felhasználó tudja élesíteni ( systemctl --user status voli-fetchmail-user.service )
		és így nem tud még véletlen sem más felhasználóba turkálni..

##	voli-fetchmail@
		A %i felhasználóra indít egy fetchmail-t

##	voli-fetchmail-starter
		Elindít minden felhasználónak egy voli-fetchmail@.service-t akinek van a $HOME könyvtárában .fetchmailrc file


##	voli-docker@
		Az /etc/voli/docker könyvtárban lévő %i.yaml file-t indítja/állítja docker-compose-zal

##	voli-docker-starter.service
		Az /etc/voli/docker könyvtárban lévő összes .yaml-re indít egy voli-docker@.service


##	voli-myshaper,voli-myshaper.service
		A forgalom korlátozást valósítja meg az internet felé

