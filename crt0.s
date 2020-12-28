; ---------------------------------------------------------------------------
; crt0.s
; ---------------------------------------------------------------------------
;
; Startup code for cc65 (C65 version)

.export   _init, _exit
.import   _main

.export   __LOADADDR__: absolute = 1

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import   __RAM_START__, __RAM_SIZE__       ; Linker generated

.import    copydata, zerobss, initlib, donelib

.include  "zeropage.inc"

.segment  "LOADADDR"
.word $2001

.segment "BASIC"

.byte $11,$20,$01,$00,$FE,$02,$20,$30,$3A,$9E,$20,$38,$32,$32,$34,$00
.byte $00,$00

; The above BASIC program is:
;
; 1 BANK 0:SYS 8224
;
; Which makes BASIC see the correct memory addresses and then jumps to
; our main code at $2020.

; ---------------------------------------------------------------------------
; The code disables interrupts and then changes the memory map so that the
; area from $2000+ becomes usable as RAM.
;
.segment  "STARTUP"

_init:    SEI
          LDA #$35
          STA $01
          LDA #0
          TAX
          TAY
          .BYTE $4B ; TAZ
          .BYTE $5C ; MAP
          NOP       ; EOM

          LDX     #$FF          ; Initialize stack pointer to $01FF
          TXS
          CLD                   ; Clear decimal mode

; ---------------------------------------------------------------------------
; Set cc65 argument stack pointer

          LDA     #<(__RAM_START__ + __RAM_SIZE__)
          STA     sp
          LDA     #>(__RAM_START__ + __RAM_SIZE__)
          STA     sp+1

; ---------------------------------------------------------------------------
; Initialize memory storage

          JSR     zerobss              ; Clear BSS segment
          JSR     copydata             ; Initialize DATA segment
          JSR     initlib              ; Run constructors

; ---------------------------------------------------------------------------
; Call main()

          JSR     _main

; ---------------------------------------------------------------------------
; Back from main (this is also the _exit entry):

_exit:    JSR     donelib              ; Run destructors
          CLI
          RTS
