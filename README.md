# Cuttleprint
Website: cuttleprint.org
Once you finish slicing, it's time to Cuttleprint up your Gode to one or many 3d printers. 
Cuttleprint is a simple way to spoon-feed Gcode to all your printers from a single computer. It will detect all your serial connections and create a control folder for each.

Flatpak
---
 - sudo flatpak-builder build-dir com.hackers_game.cuttleprint.yml
 - flatpak-builder --user --install --force-clean build-dir com.hackers_game.cuttleprint.yml
 - flatpak run com.hackers_game.cuttleprint

Setup
---
 - Run: Debian: `apt get install python3-watchdog python3-flask`
 - Run: SuSE: `sudo zypper install python3-watchdog python3-Flask python3-serial`
 - sudo usermod -a -G dialout USERNAME
 - Reboot or run `su USERNAME -`
 - Run: ./startup
 - Open: http://localhost/post-hast to config printers

Control folder structure
----
If your conntion is called `/dev/ttyACM0` you'll have the folling files:
`/dev/shm/ttyACM0/upload`
`/dev/shm/ttyACM0/printing`
`/dev/shm/ttyACM0/done`
If you have more than one printer/serial connection, you'll have the above folders for each printer. 

Printing manually
---
Copy your Gcode to `./printers/<your_printer>/upload`.
Cuttleprint will detect this, and your Gcode will be moved to `./printers/<your_printer>/printing`. This will also kick off the `gcode_send` process to spoon-feed your printer serial style. 

Cansling a print
---
Delete or move the Gcode from the printer's printing folder.
`rm ./printers/<your_printer>/printing/print_to_cansel.gcode`

Done prints
---
Once a print completes, it Gcode will be moved to `./printers/<your_printer>/done`

Licence
---
AGPL by David Hamner
