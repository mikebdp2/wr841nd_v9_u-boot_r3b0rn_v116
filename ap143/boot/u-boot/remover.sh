#!/bin/sh
mv ./mips_config.mk ./mips_conf1g.mk
rm -f ./*_config.mk
mv ./mips_conf1g.mk ./mips_config.mk
rm -rf ./board/
mkdir ./board/
touch ./board/.keep
rm -f ./common/ACEX1K.c
rm -f ./common/altera.c
rm -f ./common/bedbug.c
rm -f ./common/cmd_ace.c
rm -f ./common/cmd_autoscript.c
rm -f ./common/cmd_bdinfo.c
rm -f ./common/cmd_bedbug.c
rm -f ./common/cmd_bmp.c
rm -f ./common/cmd_diag.c
rm -f ./common/cmd_dtt.c
rm -f ./common/cmd_ext2.c
rm -f ./common/cmd_fat.c
rm -f ./common/cmd_fdc.c
rm -f ./common/cmd_fdos.c
rm -f ./common/cmd_fpga.c
rm -f ./common/cmd_i2c.c
rm -f ./common/cmd_ide.c
rm -f ./common/cmd_jffs2.c
rm -f ./common/cmd_log.c
rm -f ./common/cmd_mac.c
rm -f ./common/cmd_mmc.c
rm -f ./common/cmd_pci.c
rm -f ./common/cmd_pcmcia.c
rm -f ./common/cmd_portio.c
rm -f ./common/cmd_reiser.c
rm -f ./common/cmd_scsi.c
rm -f ./common/cmd_universe.c
rm -f ./common/cmd_usb.c
rm -f ./common/cmd_vfd.c
rm -f ./common/cmd_ximg.c
rm -f ./common/dlmalloc.src
rm -f ./common/env_dataflash.c
rm -f ./common/env_eeprom.c
rm -f ./common/env_flash.c
rm -f ./common/env_nand.c
rm -f ./common/env_nvram.c
rm -f ./common/fpga.c
rm -f ./common/ft_build.c
rm -f ./common/kgdb.c
rm -f ./common/lynxkdi.c
rm -f ./common/s_record.c
rm -f ./common/soft_i2c.c
rm -f ./common/soft_spi.c
rm -f ./common/spartan2.c
rm -f ./common/spartan3.c
rm -f ./common/usb.c
rm -f ./common/usb_kbd.c
rm -f ./common/usb_storage.c
rm -f ./common/virtex2.c
rm -f ./common/xilinx.c
mv ./cpu/mips/ ./cpu_mips/
rm -rf ./cpu/
mkdir ./cpu/
mv ./cpu_mips/ ./cpu/mips/
rm -f ./cpu/mips/asc_serial.c
rm -f ./cpu/mips/asc_serial.h
rm -f ./cpu/mips/au1x00_eth.c
rm -f ./cpu/mips/au1x00_serial.c
rm -f ./cpu/mips/au1x00_usb_ohci.c
rm -f ./cpu/mips/au1x00_usb_ohci.h
rm -f ./cpu/mips/incaip_clock.c
rm -f ./cpu/mips/incaip_wdt.S
rm -rf ./disk/
mv ./drivers/Makefile ./drivers_Makefile
mv ./drivers/pci.c ./drivers_pci_c
rm -rf ./drivers/
mkdir ./drivers/
mv ./drivers_Makefile ./drivers/Makefile
mv ./drivers_pci_c ./drivers/pci.c
rm -rf ./dtt/
rm -rf ./fs/
rm -f ./include/405_dimm.h
rm -f ./include/405_mal.h
rm -f ./include/405gp_i2c.h
rm -f ./include/405gp_pci.h
rm -f ./include/440_i2c.h
rm -f ./include/74xx_7xx.h
rm -f ./include/ACEX1K.h
rm -f ./include/ahci.h
rm -f ./include/altera.h
rm -f ./include/arm920t.h
rm -f ./include/arm925t.h
rm -f ./include/arm926ejs.h
rm -f ./include/arm946es.h
rm -f ./include/armcoremodule.h
mv ./include/asm-mips/ ./include_asm-mips/
rm -rf ./include/asm-*
mv ./include_asm-mips/ ./include/asm-mips/
rm -f ./include/asm-mips/au1x00.h
rm -f ./include/at91rm9200_i2c.h
rm -f ./include/at91rm9200_net.h
rm -f ./include/ata.h
rm -f ./include/bcm5221.h
rm -rf ./include/bedbug/
rm -f ./include/bmp_layout.h
rm -f ./include/clps7111.h
rm -f ./include/commproc.h
rm -rf ./include/configs/
mkdir ./include/configs/
touch ./include/configs/.keep
rm -rf ./include/cramfs/
rm -f ./include/dataflash.h
rm -f ./include/dm9161.h
rm -f ./include/dtt.h
rm -f ./include/e500.h
rm -f ./include/elf.h
rm -f ./include/ext2fs.h
rm -f ./include/fat.h
rm -f ./include/fdc.h
rm -f ./include/fpga.h
rm -f ./include/ft_build.h
rm -rf ./include/galileo/
rm -f ./include/i8042.h
rm -f ./include/jffs2/compr_rubin.h
rm -f ./include/jffs2/jffs2_1pass.h
rm -f ./include/jffs2/mini_inflate.h
rm -f ./include/keyboard.h
rm -f ./include/kgdb.h
rm -f ./include/lcdvideo.h
rm -f ./include/lh7a400.h
rm -f ./include/lh7a404.h
rm -f ./include/lh7a40x.h
rm -f ./include/linux/byteorder/little_endian.h
rm -f ./include/linux/mc146818rtc.h
rm -rf ./include/linux/mtd/
rm -f ./include/linux/stat.h
rm -f ./include/linux/time.h
rm -f ./include/linux_logo.h
rm -f ./include/logbuff.h
rm -f ./include/lpd7a400_cpld.h
rm -f ./include/lxt971a.h
rm -f ./include/lynxkdi.h
rm -f ./include/mii_phy.h
rm -f ./include/mmc.h
rm -f ./include/mpc106.h
rm -f ./include/mpc5xx.h
rm -f ./include/mpc5xxx.h
rm -f ./include/mpc8220.h
rm -f ./include/mpc824x.h
rm -f ./include/mpc8260.h
rm -f ./include/mpc8260_irq.h
rm -f ./include/mpc83xx.h
rm -f ./include/mpc85xx.h
rm -f ./include/mpc86xx.h
rm -f ./include/mpc8xx.h
rm -f ./include/mpc8xx_irq.h
rm -f ./include/nand.h
rm -f ./include/nios-io.h
rm -f ./include/nios.h
rm -f ./include/nios2-epcs.h
rm -f ./include/nios2-io.h
rm -f ./include/nios2.h
rm -f ./include/ns16550.h
rm -f ./include/ns7520_eth.h
rm -f ./include/ns87308.h
rm -f ./include/ns9750_bbus.h
rm -f ./include/ns9750_eth.h
rm -f ./include/ns9750_mem.h
rm -f ./include/ns9750_ser.h
rm -f ./include/ns9750_sys.h
rm -f ./include/pc_keyb.h
rm -f ./include/pcmcia.h
rm -rf ./include/pcmcia/
rm -f ./include/ppc405.h
rm -f ./include/ppc440.h
rm -f ./include/ppc4xx.h
rm -f ./include/ppc4xx_enet.h
rm -f ./include/ppc_defs.h
rm -f ./include/ps2mult.h
rm -f ./include/reiserfs.h
rm -f ./include/s3c2400.h
rm -f ./include/s3c2410.h
rm -f ./include/s3c24x0.h
rm -f ./include/s_record.h
rm -f ./include/SA-1100.h
rm -f ./include/sa1100.h
rm -f ./include/scsi.h
rm -f ./include/sed13806.h
rm -f ./include/sed156x.h
rm -f ./include/sm501.h
rm -f ./include/smiLynxEM.h
rm -f ./include/spartan2.h
rm -f ./include/spartan3.h
rm -f ./include/spd.h
rm -f ./include/spd_sdram.h
rm -f ./include/status_led.h
rm -f ./include/sym53c8xx.h
rm -f ./include/systemace.h
rm -f ./include/universe.h
rm -f ./include/usb.h
rm -f ./include/usb_defs.h
rm -f ./include/usbdcore.h
rm -f ./include/usbdcore_ep0.h
rm -f ./include/usbdcore_omap1510.h
rm -f ./include/usbdescriptors.h
rm -f ./include/vfd_logo.h
rm -f ./include/video.h
rm -f ./include/video_ad7176.h
rm -f ./include/video_ad7177.h
rm -f ./include/video_ad7179.h
rm -f ./include/video_easylogo.h
rm -f ./include/video_fb.h
rm -f ./include/video_font.h
rm -f ./include/video_logo.h
rm -f ./include/virtex2.h
rm -f ./include/w83c553f.h
rm -f ./include/xilinx.h
mv ./lib_bootstrap/ ./l1b_bootstrap/
mv ./lib_generic/ ./l1b_generic/
mv ./lib_mips/ ./l1b_mips/
rm -rf ./lib_*
mv ./l1b_bootstrap/ ./lib_bootstrap/
mv ./l1b_generic/ ./lib_generic/
mv ./l1b_mips/ ./lib_mips/
rm -f ./lib_generic/bzlib.c
rm -f ./lib_generic/bzlib_crctable.c
rm -f ./lib_generic/bzlib_decompress.c
rm -f ./lib_generic/bzlib_huffman.c
rm -f ./lib_generic/bzlib_private.h
rm -f ./lib_generic/bzlib_randtable.c
rm -f ./lib_generic/zlib.c
rm -rf ./nand_spl/
rm -f ./net/sntp.c
rm -f ./net/sntp.h
rm -rf ./tools/bddb/
rm -rf ./tools/easylogo/
rm -rf ./tools/env/
rm -rf ./tools/gdb/
rm -f ./tools/img2brec.sh
rm -f ./tools/Makefile.win32
rm -f ./tools/mpc86x_clk.c
rm -f ./tools/ncb.c
rm -rf ./tools/scripts/
rm -rf ./tools/updater/