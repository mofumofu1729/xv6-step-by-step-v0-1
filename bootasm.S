.code16
.globl start

start:
	movw	$0,%ax
	movw	%ax,%ss
	movw	$0x7c00,%sp
	movw	%ax,%ds
	movw	%ax,%es

	movw	$msg,%si
putloop:
	movb	(%si),%al
	addw	$1,%si
	cmp	$0,%al
	je	fin
	movb	$0x0e,%ah	# 1文字表示
	movw	$15,%bx		# カラーコード
	int	$0x10		# ビデオBIOS呼びだし
	jmp	putloop
fin:
	hlt
	jmp	fin

# メッセージ部分
msg:	
	.byte	0x0a, 0x0a	# 改行を二つ
	.ascii	"hello, world"
	.byte	0x0a
	.byte	0
