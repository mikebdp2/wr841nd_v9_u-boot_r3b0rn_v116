#
# (C) Copyright 2000-2006
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#
# See file CREDITS for list of people who contributed to this
# project.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#

#########################################################################

ifneq ($(OBJTREE),$(SRCTREE))
ifeq ($(CURDIR),$(SRCTREE))
dir :=
else
dir := $(subst $(SRCTREE)/,,$(CURDIR))
endif

obj := $(if $(dir),$(OBJTREE)/$(dir)/,$(OBJTREE)/)
src := $(if $(dir),$(SRCTREE)/$(dir)/,$(SRCTREE)/)

$(shell mkdir -p $(obj))
else
obj :=
src :=
endif

# clean the slate ...
PLATFORM_RELFLAGS =
PLATFORM_CPPFLAGS =
PLATFORM_LDFLAGS =

#
# When cross-compiling on NetBSD, we have to define __PPC__ or else we
# will pick up a va_list declaration that is incompatible with the
# actual argument lists emitted by the compiler.
#
# [Tested on NetBSD/i386 1.5 + cross-powerpc-netbsd-1.3]

ifeq ($(ARCH),ppc)
ifeq ($(CROSS_COMPILE),powerpc-netbsd-)
PLATFORM_CPPFLAGS+= -D__PPC__
endif
ifeq ($(CROSS_COMPILE),powerpc-openbsd-)
PLATFORM_CPPFLAGS+= -D__PPC__
endif
endif

ifeq ($(ARCH),arm)
ifeq ($(CROSS_COMPILE),powerpc-netbsd-)
PLATFORM_CPPFLAGS+= -D__ARM__
endif
ifeq ($(CROSS_COMPILE),powerpc-openbsd-)
PLATFORM_CPPFLAGS+= -D__ARM__
endif
endif

ifeq ($(ARCH),blackfin)
PLATFORM_CPPFLAGS+= -D__BLACKFIN__ -mno-underscore
endif

ifdef	ARCH
sinclude $(TOPDIR)/$(ARCH)_config.mk	# include architecture dependend rules
endif
ifdef	CPU
sinclude $(TOPDIR)/cpu/$(CPU)/config.mk	# include  CPU	specific rules
endif
ifdef	SOC
sinclude $(TOPDIR)/cpu/$(CPU)/$(SOC)/config.mk	# include  SoC	specific rules
endif
ifdef	VENDOR
BOARDDIR = $(VENDOR)/$(BOARD)
else
BOARDDIR = $(BOARD)
endif
ifdef	BOARD
sinclude $(TOPDIR)/board/$(BOARDDIR)/config.mk	# include board specific rules
endif

#########################################################################

CONFIG_SHELL	:= $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
		    else if [ -x /bin/bash ]; then echo /bin/bash; \
		    else echo sh; fi ; fi)

ifeq ($(HOSTOS)-$(HOSTARCH),darwin-ppc)
HOSTCC		= cc
else
HOSTCC		= gcc
endif
HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
HOSTSTRIP	= strip

# cu570m
COMPRESS    = lzma

#########################################################################
#
# Option checker (courtesy linux kernel) to ensure
# only supported compiler options are used
#
cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
		> /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)

#
# Include the make variables (CC, etc...)
#
AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
CC	= $(CROSS_COMPILE)gcc
CPP	= $(CC) -E
AR	= $(CROSS_COMPILE)ar
NM	= $(CROSS_COMPILE)nm
STRIP	= $(CROSS_COMPILE)strip
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
RANLIB	= $(CROSS_COMPILE)RANLIB

# cu570m
.depend : CC = $(CROSS_COMPILE)gcc

ifneq (,$(findstring s,$(MAKEFLAGS)))
ARFLAGS = cr
else
ARFLAGS = crv
endif
RELFLAGS= $(PLATFORM_RELFLAGS)
DBGFLAGS= -g # -DDEBUG
# cu570m
### R3B0RN -Os => -O ### #-fomit-frame-pointer
OPTFLAGS= -O
ifndef LDSCRIPT
#LDSCRIPT := $(TOPDIR)/board/$(BOARDDIR)/u-boot.lds.debug
ifeq ($(CONFIG_NAND_U_BOOT),y)
LDSCRIPT := $(TOPDIR)/board/$(BOARDDIR)/u-boot-nand.lds
else
LDSCRIPT := $(TOPDIR)/board/$(BOARDDIR)/u-boot.lds
endif
endif
OBJCFLAGS += --gap-fill=0xff

# cu570m
LDSCRIPT_BOOTSTRAP := $(TOPDIR)/board/$(BOARDDIR)/u-boot-bootstrap.lds

gccincdir := $(shell $(CC) -print-file-name=include)

CPPFLAGS := $(DBGFLAGS) $(OPTFLAGS) $(RELFLAGS)		\
	-D__KERNEL__ -DTEXT_BASE=$(TEXT_BASE)		\

ifneq ($(OBJTREE),$(SRCTREE))
CPPFLAGS += -I$(OBJTREE)/include2 -I$(OBJTREE)/include
endif

CPPFLAGS += -I$(TOPDIR)/include
CPPFLAGS += -fno-builtin -ffreestanding -nostdinc 	\
	-isystem $(gccincdir) -pipe $(PLATFORM_CPPFLAGS)

# cu570m
### R3B0RN $(R3B0RN_UBOOT_EXTRA_CPPFLAGS) ###
CPPFLAGS += $(R3B0RN_UBOOT_EXTRA_CPPFLAGS)

ifdef BUILD_TAG
CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes \
	-DBUILD_TAG='"$(BUILD_TAG)"'
else
CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes

# cu570m start
ifeq ($(COMPRESSED_UBOOT),1)
CFLAGS += -DCOMPRESSED_UBOOT=1
endif

ifeq ($(BUILD_OPTIMIZED),y)
### R3B0RN    -mips32r2    -mtune=mips32r2 => -mtune=34kc    ===> R3B0RN_UBOOT_EXTRA_MIPSFLAGS ###
### R3B0RN -Os => -O ===> OPTFLAGS ###
CFLAGS += -funit-at-a-time
endif
endif

ifeq ($(BUILD_TYPE),jffs2)
CFLAGS += -DROOTFS=1
else
ifeq ($(BUILD_TYPE),squashfs)
CFLAGS += -DROOTFS=2
endif
endif

ifdef ATH_SST_FLASH
CFLAGS += -DATH_SST_FLASH=1
endif

# which is used to load vxWorks.bin and run it for calibrate DUT
ifeq ($(TPWD_FOR_LINUX_CAL),1)
CFLAGS += -DTPWD_FOR_LINUX_CAL=1
endif
# cu570m end

# avoid trigraph warnings while parsing pci.h (produced by NIOS gcc-2.9)
# this option have to be placed behind -Wall -- that's why it is here
ifeq ($(ARCH),nios)
ifeq ($(findstring 2.9,$(shell $(CC) --version)),2.9)
CFLAGS := $(CPPFLAGS) -Wall -Wno-trigraphs
endif
endif

# $(CPPFLAGS) sets -g, which causes gcc to pass a suitable -g<format>
# option to the assembler.
AFLAGS_DEBUG :=

# turn jbsr into jsr for m68k
ifeq ($(ARCH),m68k)
ifeq ($(findstring 3.4,$(shell $(CC) --version)),3.4)
AFLAGS_DEBUG := -Wa,-gstabs,-S
endif
endif

AFLAGS := $(AFLAGS_DEBUG) -D__ASSEMBLY__ $(CPPFLAGS)

# cu570m start
ifeq ($(COMPRESSED_UBOOT),1)
AFLAGS += -DCOMPRESSED_UBOOT=1
endif
# cu570m end

LDFLAGS += -Bstatic -T $(LDSCRIPT) -Ttext $(TEXT_BASE) $(PLATFORM_LDFLAGS)

# cu570m start
ifeq ($(COMPRESSED_UBOOT), 1)
LDFLAGS_BOOTSTRAP += -Bstatic -T $(LDSCRIPT_BOOTSTRAP) -Ttext $(BOOTSTRAP_TEXT_BASE) $(PLATFORM_LDFLAGS)
endif
# cu570m end

# Location of a usable BFD library, where we define "usable" as
# "built for ${HOST}, supports ${TARGET}".  Sensible values are
# - When cross-compiling: the root of the cross-environment
# - Linux/ppc (native): /usr
# - NetBSD/ppc (native): you lose ... (must extract these from the
#   binutils build directory, plus the native and U-Boot include
#   files don't like each other)
#
# So far, this is used only by tools/gdb/Makefile.

ifeq ($(HOSTOS)-$(HOSTARCH),darwin-ppc)
BFD_ROOT_DIR =		/usr/local/tools
else
ifeq ($(HOSTARCH),$(ARCH))
# native
BFD_ROOT_DIR =		/usr
else
#BFD_ROOT_DIR =		/LinuxPPC/CDK		# Linux/i386
#BFD_ROOT_DIR =		/usr/pkg/cross		# NetBSD/i386
BFD_ROOT_DIR =		/opt/powerpc
endif
endif

ifeq ($(PCI_CLOCK),PCI_66M)
CFLAGS := $(CFLAGS) -DPCI_66M
endif

# cu570m
### R3B0RN $(UBOOT_GCC_4_3_3_EXTRA_CFLAGS) => $(R3B0RN_UBOOT_EXTRA_MIPSFLAGS) ###
CFLAGS += -g

#########################################################################

export	CONFIG_SHELL HPATH HOSTCC HOSTCFLAGS CROSS_COMPILE \
	AS LD CC CPP AR NM STRIP OBJCOPY OBJDUMP \
	MAKE
export	TEXT_BASE PLATFORM_CPPFLAGS PLATFORM_RELFLAGS CPPFLAGS CFLAGS AFLAGS

#########################################################################

# cu570m start
# ifeq ($(V),1)
#   Q =
# else
#   Q = @
# endif
#
# export quiet Q V
# cu570m end

# CPP -> Q,CPP - cu570m start
ifndef REMOTE_BUILD

%.s:	%.S
ifneq ($(V),1)
	@echo [CPP] $(abspath $(CURDIR)/$<)
endif
	$(CPP) $(AFLAGS) -o $@ $<

%.o:	%.S
ifneq ($(V),1)
	@echo [CC] $(abspath $(CURDIR)/$<)
endif
	$(CC) $(AFLAGS) -c -o $@ $<

%.o:	%.c
ifneq ($(V),1)
	@echo [CC] $(abspath $(CURDIR)/$<)
endif
	$(CC) $(CFLAGS) -c -o $@ $<

else

$(obj)%.s:	%.S
ifneq ($(V),1)
	@echo [CPP] $(abspath $(CURDIR)/$<)
endif
	$(CPP) $(AFLAGS) -o $@ $<

$(obj)%.o:	%.S
ifneq ($(V),1)
	@echo [CC] $(abspath $(CURDIR)/$<)
endif
	$(CC) $(AFLAGS) -c -o $@ $<

$(obj)%.o:	%.c
ifneq ($(V),1)
	@echo [CC] $(abspath $(CURDIR)/$<)
endif
	$(CC) $(CFLAGS) -c -o $@ $<

endif
# CPP -> Q,CPP - cu570m end

#########################################################################
