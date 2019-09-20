# systemd-init
	Az álltalam készített systemd alatt működő szolgáltatásaim és azok kezelése.
	Azért van "voli-" előtag, hogy még véletlenül se keveredjenek az alap service-kel 
	és egy helyen legyenek.

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
		A docker.service-nek jobb ha a /var/lib/docker egy csatolási pont,
		így minden adata külön volume-ra kerülhet

##	edit-voli-openvpn.sh
		Az openvpn@service mindíg induljon újra

##	*-starter
		Autómatán indítja a * service-ket megfelelő névvel, ezt lehet helyetesíteni symlink-kel pl.:
		ln -s /etc/systemd/system/voli-fetchmail@.service /etc/systemd/system/default.target.wants/voli-fetchmail@<usernev>.service


##	voli-mythtv-switch.service
		A MythTV fronted-jét (megjelenítő/TV)  ki/be kapcsolgatja, jellemzően a távirányító használja

##	voli-irexec.service, voli-lirc.service
		Kellenek a távirányítóhoz tiltja a lirc-et

##	voli-rc, voli-rc.service
		Induláskor ezeket kell beállítani

##	voli-myshaper,voli-myshaper.service
		A forgalom korlátozást valósítja meg az internet felé

##	voli-openvpn-starter.service
		Minden OpenVPN configra indít egy service-t, a gyári Unit-ot így modosítottam:
			[Service]
			    RestartSec=30
			    Restart=always
		Illetve az edit-voli-openvpn script ezt végleg megcsinálja

##	voli-fetchmail@%i
		A %i felhasználóra indít egy fetchmail-t
##	voli-fetchmail-starter
		Elindít minden felhasználónak egy voli-fetchmail@.service-t akinek van a $HOME könyvtárában .fetchmailrc file

##	voli-docker@
		Az /etc/voli/docker könyvtárban lévő %i.yaml file-t indítja/állítja docker-compose-zal
		A systemctl enable voli-docker@teszt.service 	Következő boot-nál már elindul...
##	voli-docker-stop.service
		Az /etc/voli/docker könyvtárban lévő minden *.yaml file-ra indít egy stop parancsot
		    
##	voli-docker-starter.service	ELAVULT
		Az /etc/voli/docker könyvtárban lévő összes .yaml-re indít egy voli-docker@.service


##	voli-syncthing@.service
		Az /etc/voli-syncthing -ben található konfig a paramétere
##	voli-syncthing-starter.service
		Minden az /etc/voli-syncthing -ben található configra indít egy voli-syncthing@.service-t


##	Voli-titok-[disk|lvm|mount] 

	Megnyitja a titkosított diszeket, összerakja a rajtuk lévő LVM-et, majd csatolja

	Feltételek:
	    /etc/cypttab kitöltve: pl. akár több soron átt; komment lehet (^#); noauto kell, mivel bootkor még nincs kulcs
		és "Titok_" kell kezdeni a <target name>-t
		# <target name>			<source device>		<key file>				<options>
		Titok_Diszk_Így_lesz_Nevezve 	UUID=A_Diszk_UUID-je 	A_kulcs_helye_ami_nyitja_a_diszket 	luks,noauto
		Titok_Diszk_Így_lesz_NevezveX 	UUID=A_Diszk_UUID-jeX 	A_kulcs_helye_ami_nyitja_a_diszketX 	luks,noauto

	    /etc/fstab a csatolásoknak itt kellelennie pl.
		/dev/vgtitok/titkok 	/srv/titkos 	btrfs 	noauto,nodev,nosuid,noexec,subvol=/titkom 	0 	7

	    /etc/voli/titok.env itt vannak a paraméterek

##	voli-titok-disk
	    Az /etc/crypttab -ban lévő összes "noauto" és kulcsfile-al (nem none, ami jelszavas lenne) rendelkező
	    diszket indítja/állítja

##	voli-titok-lvm
	    Megkeresi és (de)aktiválja az LVM köteteket és VG-ket

	voli-titok-mount
	    (Le)Csatolja a titkosított diszkeken lévő filesystemeket




