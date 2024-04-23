# Test-Assembly-Kernel

Minimalistischer Bootloader und Protected Mode Kernel
Dieser minimalistische Bootloader wird in Assembler geschrieben und ist für den Einsatz auf x86-Architektur entwickelt. Der Code beginnt im 16-Bit-Real-Mode und setzt wichtige Register, bevor er eine eigene GDT (Global Descriptor Table) lädt und in den 32-Bit-Protected-Mode wechselt. Der Bootloader setzt auch das Stack-Segment und den Stack-Pointer, bevor er die Kontrolle an den rudimentären Kernel-Code übergibt.

Hauptmerkmale:
- 16-Bit-Real-Mode Initialisierung: Setzt wichtige Register und den Stack.
- Wechsel in den Protected Mode: Der Bootloader aktiviert den Protected Mode durch Konfiguration des CR0-Registers und einen Far Jump, der das Code-Segment aktualisiert.
- Eigene GDT: Definiert eine einfache GDT für Code- und Daten-Segmente.
- Endlosschleife im Protected Mode: Der Kernel tritt nach der Initialisierung in eine Endlosschleife ein, die als Platzhalter für weiteren Kernel-Code dienen kann.
  
Anwendungszweck:
Dieser Code kann als Grundlage für Bildungszwecke oder als Ausgangspunkt für die Entwicklung eines eigenen Betriebssystems verwendet werden.

Hinweis:
Dieser Bootloader muss in den ersten 512 Bytes eines bootfähigen Mediums platziert werden und endet mit dem typischen Boot-Signatur-Byte 0xAA55.
