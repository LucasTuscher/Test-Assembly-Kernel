; Boot.asm
[BITS 16]                  ; Code im 16-Bit-Real-Mode schreiben
[ORG 0x7C00]               ; Origin, BIOS lädt Bootsektor an diese Adresse

start:
    cli                    ; Interrupts deaktivieren
    mov ax, cs             ; Segmentregister setzen
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ax, 0x9000         ; Stacksegment auf 0x9000 setzen
    mov ss, ax
    mov sp, 0xFFFF         ; Stackpointer auf 0xFFFF setzen
    sti                    ; Interrupts wieder aktivieren

    ; Wechsel in den Protected Mode
    call switch_to_pm

hang:
    jmp hang               ; Endlosschleife

switch_to_pm:
    cli                    ; Interrupts deaktivieren
    lgdt [gdt_descriptor]  ; Global Descriptor Table laden

    mov eax, cr0
    or eax, 1
    mov cr0, eax           ; Protected Mode aktivieren

    jmp CODE_SEG:init_pm   ; Far Jump, um CS zu aktualisieren

[BITS 32]                  ; Nun im 32-Bit-Modus
init_pm:
    mov ax, DATA_SEG       ; Daten-Segmentregister setzen
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; Hier könnte Ihr Kernel-Code starten

    jmp $                  ; Springe zu aktueller Adresse (Endlosschleife)

gdt_data:
    dw 0xFFFF   ; Limit low
    dw 0        ; Base low
    db 0        ; Base middle
    db 10011010b; Access
    db 11001111b; Granularity
    db 0        ; Base high

gdt_code:
    dw 0xFFFF
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_data - 1
    dd gdt_data

CODE_SEG equ gdt_code - gdt_data
DATA_SEG equ gdt_data - gdt_data

TIMES 510 - ($ - $$) db 0   ; Padde den Bootsektor auf 510 Bytes mit Nullen
dw 0xAA55                   ; Boot-Signatur
