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

.byte     $2D,$20,$01,$00,$81,$20,$49,$B2,$31,$32,$38,$30,$20,$A4,$20
.byte $31,$32,$39,$34,$3A,$87,$20,$58,$3A,$97,$20,$49,$2C,$58,$3A,$97
.byte $20,$35,$33,$32,$38,$30,$2C,$58,$3A,$82,$20,$49,$00,$5E,$20,$02
.byte $00,$83,$20,$31,$32,$30,$2C,$31,$36,$39,$2C,$35,$33,$2C,$31,$33
.byte $33,$2C,$31,$2C,$31,$36,$39,$2C,$30,$2C,$31,$37,$30,$2C,$31,$36
.byte $38,$2C,$37,$35,$2C,$39,$32,$2C,$32,$33,$34,$2C,$37,$36,$2C,$31
.byte $32,$38,$2C,$33,$32,$00,$71,$20,$03,$00,$9E,$20,$31,$32,$38,$30
.byte $00,$00

; This BASIC program pokes the following machine code to $500 and
; jumps there. The machine code changes the memory map so that the
; area from $2000+ becomes usable as RAM.

; SEI
; LDA #$35
; STA $01
; LDA #0
; TAX
; TAY
; .BYTE $4B                     ; TAZ
; .BYTE $5C                     ; MAP
; NOP                           ; EOM
; JMP $2080                     ; STARTUP

; ---------------------------------------------------------------------------
; Place the startup code in a special segment

.segment  "STARTUP"

_init:    LDX     #$FF          ; Initialize stack pointer to $01FF
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
