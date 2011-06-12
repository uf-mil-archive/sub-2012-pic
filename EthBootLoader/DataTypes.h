//////////////////////////////////////////////////////////////////////////
//	DataTypes.h Project Header File for the UPD Server Application
//	MCHP C30 Specific file for the PIC24 series
//
//		Copyright (c) 2008, Andrew Smallridge
//
//		Last Modified 28/03/08
///////////////////////////////////////////////////////////////////////////

typedef unsigned char	DSTATUS;
typedef unsigned char	DRESULT;
typedef unsigned char	FRESULT;
typedef unsigned char	BYTE;
typedef unsigned char*	pBYTE;
typedef unsigned short int	WORD;
typedef signed int		sWORD;
typedef unsigned long	DWORD;
//typedef unsigned char	BOOLEAN;
typedef unsigned char*	pchar;
typedef enum _BOOLEAN { FALSE = 0, TRUE } BOOLEAN;


typedef union _BYTE_VAL
{
    struct
    {
        unsigned int b0:1;
        unsigned int b1:1;
        unsigned int b2:1;
        unsigned int b3:1;
        unsigned int b4:1;
        unsigned int b5:1;
        unsigned int b6:1;
        unsigned int b7:1;
    } bits;
    BYTE Val;
} BYTE_VAL;

typedef union _WORD_VAL
{
    WORD Val;
    struct
    {
        BYTE LSB;
        BYTE MSB;
    };
    BYTE v[2];
} WORD_VAL;



typedef union _DWORD_VAL
	{
	DWORD Val;
	WORD w[2];
	BYTE v[4];
	struct
		{
		WORD LW;
		WORD HW;
		} word;
	struct
		{
		BYTE LB;
		BYTE HB;
		BYTE UB;
		BYTE MB;
		} byte;
	struct
		{
		unsigned char b0:1;
		unsigned char b1:1;
		unsigned char b2:1;
		unsigned char b3:1;
		unsigned char b4:1;
		unsigned char b5:1;
		unsigned char b6:1;
		unsigned char b7:1;
		unsigned char b8:1;
		unsigned char b9:1;
		unsigned char b10:1;
		unsigned char b11:1;
		unsigned char b12:1;
		unsigned char b13:1;
		unsigned char b14:1;
		unsigned char b15:1;
		unsigned char b16:1;
		unsigned char b17:1;
		unsigned char b18:1;
		unsigned char b19:1;
		unsigned char b20:1;
		unsigned char b21:1;
		unsigned char b22:1;
		unsigned char b23:1;
		unsigned char b24:1;
		unsigned char b25:1;
		unsigned char b26:1;
		unsigned char b27:1;
		unsigned char b28:1;
		unsigned char b29:1;
		unsigned char b30:1;
		unsigned char b31:1;
		} bits;
	} DWORD_VAL;


#define LSB(a)          ((a).v[0])
#define MSB(a)          ((a).v[1])

#define FALSE 0
#define TRUE 1

#define	LD_WORD(ptr)		(*(WORD*)(BYTE*)(ptr))
#define	LD_DWORD(ptr)		(*(DWORD*)(BYTE*)(ptr))
#define	ST_WORD(ptr,val)	*(WORD*)(BYTE*)(ptr)=(val)
#define	ST_DWORD(ptr,val)	*(DWORD*)(BYTE*)(ptr)=(val)
