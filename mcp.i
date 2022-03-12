	IFND	A2560K_MCP_I_INCLUDED_
A2560K_MCP_I_INCLUDED_ = 1

SYSCALL:	MACRO
		moveq	#sys_\1,d0
		trap	#15
		ENDM

SYSDEF:		MACRO
sys_\1		RS.B	1
		ENDM

		RSSET	0
		SYSDEF	exit
		SYSDEF	RESERVED_1
		SYSDEF	int_register
		SYSDEF	int_enable
		SYSDEF	int_disable
		SYSDEF	int_enable_all
		SYSDEF	int_disable_all
		SYSDEF	int_clear
		SYSDEF	int_pending
		SYSDEF	get_info	

		RSSET	$10
		SYSDEF	chan_read
		SYSDEF	chan_read_b
		SYSDEF	chan_read_line
		SYSDEF	chan_write
		SYSDEF	chan_write_b
		SYSDEF	chan_flush
		SYSDEF	chan_seek
		SYSDEF	chan_status
		SYSDEF	chan_ioctrl
		SYSDEF	chan_register
		SYSDEF	chan_open
		SYSDEF	chan_close
		SYSDEF	chan_setsizes

		RSSET	$20
		SYSDEF	bdev_getblock
		SYSDEF	bdev_writeblock
		SYSDEF	bdev_flush
		SYSDEF	bdev_status
		SYSDEF	bdev_ioctrl
		SYSDEF	bdev_register

		RSSET	$30
		SYSDEF	fsys_open
		SYSDEF	fsys_close
		SYSDEF	fsys_opendir
		SYSDEF	fsys_closedir
		SYSDEF	fsys_readdir
		SYSDEF	fsys_findfirst
		SYSDEF	fsys_findnext
		SYSDEF	fsys_delete
		SYSDEF	fsys_rename
		SYSDEF	fsys_mkdir
		SYSDEF	fsys_load
		SYSDEF	fsys_get_label
		SYSDEF	fsys_set_label
		SYSDEF	fsys_set_cwd
		SYSDEF	fsys_get_cwd
		SYSDEF	fsys_register_loader

		RSSET	$40
		SYSDEF	proc_run

		RSSET	$50
		SYSDEF	time_jiffies
		SYSDEF	time_setrtc
		SYSDEF	time_getrtc
		SYSDEF	kbd_scancode
		SYSDEF	kbd_setlayout
		SYSDEF	err_message

	ENDC		
