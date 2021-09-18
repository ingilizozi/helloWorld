; hello world.asm

        global  _start
        extern  _ExitProcess@4      ; stdcall calling convention: leading _, trailing @, number of bytes in parameter list in decimal
        extern  _GetStdHandle@4
        extern  _WriteConsoleA@20

        section .data
msg:    db      'Hello World!', 0xA     ; 0xA denotes a new line
handle: db      0

        section .text
_start:
        ; handle = GetStdHandle(-11)
        push    dword -11       ; -11 denotes standard output device, initially this is the active console screen buffer
        call    _GetStdHandle@4
        mov     [handle], eax   ; eax contains return value from GetStdHandle()

        ; WriteConsole(handle, &msg, 13, &written, 0)
        push    dword 0             ; reserved: must be null
        push    dword 0             ; optional out parameter: number of actual characters written
        push    dword 13            ; number of characters to write
        push    msg                 ; buffer to write
        push    dword [handle]      ; handle to console window
        call    _WriteConsoleA@20   ; direct win32 API call

        ; ExitProcess(0)
        push    dword 0
        call    _ExitProcess@4