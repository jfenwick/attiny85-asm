# attiny85-asm

Examples of AVR assembly I've collected from the internet and modified to work with the gavrasm assembler for the attiny85.

Example build:
gavrasm tests.s

Example Upload:
C:\Users\jacob\.platformio\packages\tool-avrdude\avrdude.exe -C "C:\Users\jacob\.platformio\packages\tool-avrdude\avrdude.conf" -v -p attiny85 -c usbtiny -U flash:w:tests.hex:i
