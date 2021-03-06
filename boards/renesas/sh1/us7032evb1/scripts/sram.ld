/****************************************************************************
 * boards/renesas/sh1/us7032evb1/scripts/sram.ld
 *
 *   Copyright (C) 2008 Gregory Nutt. All rights reserved.
 *   Author: Gregory Nutt <gnutt@nuttx.org>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name NuttX nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/

OUTPUT_ARCH(sh)
ENTRY(_stext)
SECTIONS
{
    /* The us7032evb1 has CMON in PROM beginning at address 0x00000000 and
     * either 64Kb or 256Kb of SRAM beginning at 0x0a000000.  Neither the
     * PROM nor the first 8Kb of SRAM are available to the devoleper as these
     * are used by CMON.  The next 1Kb of SRAM is dedicated to relocated
     * interrupt vectors.
     */

    . = 0x0a002000;
    .text : {
        _svect = ABSOLUTE(.);
        *(.vects);      /* Relocated interrupt vectors  */
        _evect = ABSOLUTE(.);
        _stext = ABSOLUTE(.);
        *(.reset)       /* Reset/IRQ code       */
        *(.text)        /* Code             */
        *(.fixup)
        *(.gnu.warning)
        *(.rodata)      /* Read-only data       */
        *(.rodata.str1.4)
        *(.glue_7)
        *(.glue_7t)
        *(.got)         /* Global offset table      */
        _etext = ABSOLUTE(.);
    }

    .data : {
        _sdata = ABSOLUTE(.);
        *(.data)        /* Modifiable data      */
        CONSTRUCTORS
        . = ALIGN(4);
        _edata = ABSOLUTE(.);
    }

    .bss : {            /* BSS              */
        _sbss = ABSOLUTE(.);
        *(.bss)
        *(COMMON)
        . = ALIGN(4);
        _ebss = ABSOLUTE(.);
    }
    /* Stabs debugging sections.    */
    .stab 0 : { *(.stab) }
    .stabstr 0 : { *(.stabstr) }
    .stab.excl 0 : { *(.stab.excl) }
    .stab.exclstr 0 : { *(.stab.exclstr) }
    .stab.index 0 : { *(.stab.index) }
    .stab.indexstr 0 : { *(.stab.indexstr) }
    .comment 0 : { *(.comment) }
    .debug_abbrev 0 : { *(.debug_abbrev) }
    .debug_info 0 : { *(.debug_info) }
    .debug_line 0 : { *(.debug_line) }
    .debug_pubnames 0 : { *(.debug_pubnames) }
    .debug_aranges 0 : { *(.debug_aranges) }
}
