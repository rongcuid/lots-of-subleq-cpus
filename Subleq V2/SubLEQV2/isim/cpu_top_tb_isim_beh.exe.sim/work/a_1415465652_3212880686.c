/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Library/Projects/Subeq/Subleq V2/Sources/CPU.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
char *ieee_p_1242562249_sub_3273497107_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_3273568981_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_3410769178_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_3838596133_1035706684(char *, char *, char *, int );
char *ieee_p_1242562249_sub_4004982826_1035706684(char *, char *, char *, char *, int );


static void work_a_1415465652_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    xsi_set_current_line(54, ng0);

LAB3:    t1 = (t0 + 5544);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1415465652_3212880686_p_1(char *t0)
{
    char t15[16];
    char t20[16];
    char t21[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    static char *nl0[] = {&&LAB11, &&LAB12, &&LAB13, &&LAB14, &&LAB15, &&LAB16};

LAB0:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 5448);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(59, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t5 = t1;
    memset(t5, (unsigned char)2, 32U);
    t6 = (t0 + 5608);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 32U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(60, ng0);
    t1 = (t0 + 5672);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 2152U);
    t6 = *((char **)t2);
    t13 = *((unsigned char *)t6);
    t2 = (char *)((nl0) + t13);
    goto **((char **)t2);

LAB7:    t2 = (t0 + 1032U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

LAB10:    goto LAB3;

LAB11:    xsi_set_current_line(63, ng0);
    t7 = (t0 + 5672);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)1;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(64, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 9056U);
    t5 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t15, t2, t1, 4);
    t6 = (t0 + 5608);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t5, 32U);
    xsi_driver_first_trans_fast(t6);
    goto LAB10;

LAB12:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 5672);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(68, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t16 = (31 - 31);
    t17 = (t16 * 1U);
    t18 = (0 + t17);
    t1 = (t2 + t18);
    t5 = (t0 + 5736);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 16U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(69, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t16 = (31 - 15);
    t17 = (t16 * 1U);
    t18 = (0 + t17);
    t1 = (t2 + t18);
    t5 = (t0 + 5800);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(70, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t16 = (31 - 7);
    t17 = (t16 * 1U);
    t18 = (0 + t17);
    t1 = (t2 + t18);
    t5 = (t0 + 5864);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    goto LAB10;

LAB13:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 5672);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB14:    xsi_set_current_line(75, ng0);
    t1 = (t0 + 5672);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(76, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 5928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 32U);
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB15:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 5672);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(80, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t1 = (t0 + 9104U);
    t5 = (t0 + 1992U);
    t6 = *((char **)t5);
    t5 = (t0 + 9040U);
    t7 = ieee_p_1242562249_sub_3273568981_1035706684(IEEE_P_1242562249, t15, t2, t1, t6, t5);
    t8 = (t0 + 5928);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t14 = (t10 + 56U);
    t19 = *((char **)t14);
    memcpy(t19, t7, 32U);
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(81, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 9088U);
    t5 = ieee_p_1242562249_sub_3410769178_1035706684(IEEE_P_1242562249, t21, t2, t1, 32);
    t6 = ieee_p_1242562249_sub_4004982826_1035706684(IEEE_P_1242562249, t20, t5, t21, 2);
    t7 = (t0 + 2312U);
    t8 = *((char **)t7);
    t7 = (t0 + 9056U);
    t9 = ieee_p_1242562249_sub_3273497107_1035706684(IEEE_P_1242562249, t15, t6, t20, t8, t7);
    t10 = (t0 + 3408U);
    t14 = *((char **)t10);
    t10 = (t14 + 0);
    t19 = (t15 + 12U);
    t16 = *((unsigned int *)t19);
    t17 = (1U * t16);
    memcpy(t10, t9, t17);
    xsi_set_current_line(82, ng0);
    t1 = (t0 + 3408U);
    t2 = *((char **)t1);
    t1 = (t0 + 5992);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 32U);
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB16:    xsi_set_current_line(84, ng0);
    t1 = (t0 + 5672);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(85, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t1 = (t0 + 9104U);
    t3 = ieee_p_1242562249_sub_3838596133_1035706684(IEEE_P_1242562249, t2, t1, 0);
    if (t3 != 0)
        goto LAB17;

LAB19:
LAB18:    goto LAB10;

LAB17:    xsi_set_current_line(86, ng0);
    t5 = (t0 + 3112U);
    t6 = *((char **)t5);
    t5 = (t0 + 5608);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t6, 32U);
    xsi_driver_first_trans_fast(t5);
    goto LAB18;

}

static void work_a_1415465652_3212880686_p_2(char *t0)
{
    char t10[16];
    char t15[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned char t8;
    char *t9;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t16;
    static char *nl0[] = {&&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8};

LAB0:    xsi_set_current_line(96, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t2 = t1;
    memset(t2, (unsigned char)2, 32U);
    t3 = (t0 + 3648U);
    t4 = *((char **)t3);
    t3 = (t4 + 0);
    memcpy(t3, t1, 32U);
    xsi_set_current_line(97, ng0);
    t1 = (t0 + 6056);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(98, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t2 = t1;
    memset(t2, (unsigned char)8, 32U);
    t3 = (t0 + 6120);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 32U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(99, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t2 = t1;
    memset(t2, (unsigned char)8, 32U);
    t3 = (t0 + 6184);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 32U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(100, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t8 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t8);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 5464);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(101, ng0);
    t3 = (t0 + 2312U);
    t4 = *((char **)t3);
    t3 = (t0 + 6120);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    memcpy(t9, t4, 32U);
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB4:    xsi_set_current_line(102, ng0);
    goto LAB2;

LAB5:    xsi_set_current_line(103, ng0);
    t1 = (t0 + 3528U);
    t2 = *((char **)t1);
    t1 = (t0 + 2472U);
    t3 = *((char **)t1);
    t4 = ((IEEE_P_2592010699) + 4024);
    t5 = (t0 + 9136U);
    t6 = (t0 + 9072U);
    t1 = xsi_base_array_concat(t1, t10, t4, (char)97, t2, t5, (char)97, t3, t6, (char)101);
    t11 = (16U + 16U);
    t8 = (32U != t11);
    if (t8 == 1)
        goto LAB9;

LAB10:    t7 = (t0 + 6120);
    t9 = (t7 + 56U);
    t12 = *((char **)t9);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 32U);
    xsi_driver_first_trans_fast_port(t7);
    goto LAB2;

LAB6:    xsi_set_current_line(106, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 9088U);
    t3 = ieee_p_1242562249_sub_3410769178_1035706684(IEEE_P_1242562249, t10, t2, t1, 32);
    t4 = (t0 + 3648U);
    t5 = *((char **)t4);
    t4 = (t5 + 0);
    t6 = (t10 + 12U);
    t11 = *((unsigned int *)t6);
    t11 = (t11 * 1U);
    memcpy(t4, t3, t11);
    xsi_set_current_line(108, ng0);
    t1 = (t0 + 3648U);
    t2 = *((char **)t1);
    t1 = (t0 + 9152U);
    t3 = ieee_p_1242562249_sub_4004982826_1035706684(IEEE_P_1242562249, t10, t2, t1, 2);
    t4 = (t0 + 3648U);
    t5 = *((char **)t4);
    t4 = (t5 + 0);
    t6 = (t10 + 12U);
    t11 = *((unsigned int *)t6);
    t11 = (t11 * 1U);
    memcpy(t4, t3, t11);
    xsi_set_current_line(110, ng0);
    t1 = (t0 + 3648U);
    t2 = *((char **)t1);
    t1 = (t0 + 9152U);
    t3 = (t0 + 2472U);
    t4 = *((char **)t3);
    t3 = (t0 + 9072U);
    t5 = ieee_p_1242562249_sub_3410769178_1035706684(IEEE_P_1242562249, t15, t4, t3, 32);
    t6 = ieee_p_1242562249_sub_3273497107_1035706684(IEEE_P_1242562249, t10, t2, t1, t5, t15);
    t7 = (t0 + 3648U);
    t9 = *((char **)t7);
    t7 = (t9 + 0);
    t12 = (t10 + 12U);
    t11 = *((unsigned int *)t12);
    t16 = (1U * t11);
    memcpy(t7, t6, t16);
    xsi_set_current_line(111, ng0);
    t1 = (t0 + 3648U);
    t2 = *((char **)t1);
    t1 = (t0 + 6120);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 32U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB7:    xsi_set_current_line(112, ng0);
    goto LAB2;

LAB8:    xsi_set_current_line(114, ng0);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t2 = t1;
    memset(t2, (unsigned char)2, 16U);
    t3 = (t0 + 6120);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 16U);
    xsi_driver_first_trans_delta(t3, 0U, 16U, 0LL);
    xsi_set_current_line(115, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t1 = (t0 + 6120);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_delta(t1, 16U, 16U, 0LL);
    xsi_set_current_line(116, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t1 = (t0 + 6184);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 32U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(117, ng0);
    t1 = (t0 + 6056);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB9:    xsi_size_not_matching(32U, t11, 0);
    goto LAB10;

}


extern void work_a_1415465652_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1415465652_3212880686_p_0,(void *)work_a_1415465652_3212880686_p_1,(void *)work_a_1415465652_3212880686_p_2};
	xsi_register_didat("work_a_1415465652_3212880686", "isim/cpu_top_tb_isim_beh.exe.sim/work/a_1415465652_3212880686.didat");
	xsi_register_executes(pe);
}
