# Rendszer
Rendszer üzemeltetéshez kapcsolódó dolgok

    ## CRON

	    smart_elteres [alap]
		A tárolók smart státuszának változását figyeli naponta futtatva
		ln -s ../voli/cron/smart_elteres /etc/cron.daily/Smart_elteres
		    [ alap ] ekkor készíti el a viszonyítási alapot
		A /etc/Rendszer/smart_kivetelek fie-ban vannak azok az atributumok amelyeket nem kell vizsgálni

	    vpn_key_time
		Az openvpn p12-es kulcsainak lejárati idejét figyeli

	    mem_cache_flush
		A cache-ek üresíti ki

	    vpn_Munin
		A munin cliensek openvpn-en keresztül csatlakoznak be és azt ellenőrzi, hogy 
		a munin configban és az openvpn állapotában keres eltéréseket.

	    idokep_db [mentes]
		A helyi időkép autómatából kiolvassa (webes interface ) az adatokat és betölti egy adatbázisba
		illetve menteni is tudja az adatbázist

	    idokep_ellenorzes
		Egy időkép állomás (volaricsi) adatainak frisseségét ellenőrzi (mikori adatok vannaz az időkép oldalán)



    ## INIT
		Saját leíró file-a van
