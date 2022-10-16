# Dice
Once you finish slicing, it's time to Dice up your Gode to one or many 3d printers. 
Dice is a simple way to spoon-feed Gcode to all your printers from a single computer. It will detect all your serial connections and create a control folder for each.

Setup
---
Run: `apt get install python3-watchdog`
Edit `./printer_settings.txt` with the serial connection names in /dev/ and the needed baud rate. If your serial connection is `/dev/ttyACM0` and your baud rate is `250000`, the config line would look like this: `ttyACM0:250000`
Typical baud rates are 9600,115200,250000 but will vary depending on your printer. 
Make sure to add a line for each of your printers. 

Control folder structure
----
If your conntion is called `/dev/ttyACM0` you'll have the folling files:
`./printers/ttyACM0/upload`
`./printers/ttyACM0/printing`
`./printers/ttyACM0/done`
If you have more than one printer/serial connection, you'll have the above folders for each printer. 

Printing
---
Copy your Gcode to `./printers/<your_printer>/upload`.
Dice will detect this, and your Gcode will be moved to `./printers/<your_printer>/printing`. This will also kick off the `gcode_send` process to spoon-feed your printer serial style. 

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
