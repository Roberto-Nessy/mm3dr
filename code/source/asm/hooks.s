.arm
.text

@ .global hook_Start
@ hook_Start:
@     push {r0-r12, lr}
@     bl _start
@     pop {r0-r12, lr}
@     b 0x0103ECC

.global hook_MainLoop
hook_MainLoop:
    push {r0-r12, lr}
    bl calc
    pop {r0-r12, lr}
    ldr r1, [r0,#0x138]
    b 0x0106770


.global rActiveItemRow
.rActiveItemRow_addr:
    .word rActiveItemRow

.global hook_SaveFile_Init
hook_SaveFile_Init:
    push {r0-r12, lr}
    mov r0, r5
    bl SaveFile_Init
    pop {r0-r12, lr}
    strh r1, [r4, #0x10]
    bx lr

.global hook_OverrideDrawIndex
hook_OverrideDrawIndex:
    push {r0-r12, lr}
    bl ItemOverride_OverrideDrawIndex
    pop {r0-r12, lr}
    ldr r0,[r4,#0x274]
    b 0x1FF024

.global hook_OverrideTextID
hook_OverrideTextID:
    ldr r2,.rActiveItemRow_addr
    ldr r2,[r2]
    cmp r2,#0x0
    beq noOverrideTextID
    b 0x231104
noOverrideTextID:
    cpy r0, r7
    b 0x231100

.global hook_OverrideItemID
hook_OverrideItemID:
    ldr r2,.rActiveItemRow_addr
    ldr r2,[r2]
    cmp r2,#0x0
    beq noOverrideItemID
    push {r0-r12, lr}
    cpy r0,r2
    bl ItemOverride_GetItemTextAndItemID
    pop {r0-r12, lr}
    b 0x231110
noOverrideItemID:
    cpy r0, r7
    b 0x23110C

.global hook_IncomingGetItemID
hook_IncomingGetItemID:
    push {r0-r12, lr}
    @ According to Ghidra, r6 r5 r4 are the required 
    @ values needed for the GetItem header, if it isn't clear.
    cpy r0,r6
    cpy r1,r5
    cpy r2,r4
    bl ItemOverride_GetItem
    pop {r0-r12, lr}
    bx lr

.global hook_readGamePad
hook_readGamePad:
    push {r0-r12, lr}
    bl readPadInput
    pop {r0-r12, lr}
    tst r0,r1
    b 0x59ba14

.section .loader
.global hook_into_loader
hook_into_loader:
    push {r0-r12, lr}
    bl loader_main
    pop {r0-r12, lr}
    bl 0x100024
    b  0x100004
