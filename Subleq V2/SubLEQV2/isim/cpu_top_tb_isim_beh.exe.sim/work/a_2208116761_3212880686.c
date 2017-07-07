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
extern char *STD_TEXTIO;
static const char *ng1 = "filehandle";
extern char *STD_STANDARD;
extern char *IEEE_P_3564397177;
extern char *IEEE_P_2592010699;
static const char *ng5 = "D:/Library/Projects/Subeq/Subleq V2/Sources/cpu_top_tb.vhd";

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
void ieee_p_3564397177_sub_3988856810_91900896(char *, char *, char *, char *, char *);


char *work_a_2208116761_3212880686_sub_4079585148_3057020925(char *t1, char *t2, char *t3)
{
    char t4[448];
    char t5[24];
    char t17[16];
    char t24[32];
    char t35[32];
    char t44[32768];
    char t53[8];
    char *t0;
    char *t6;
    char *t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t18;
    char *t19;
    int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    unsigned char t33;
    unsigned int t34;
    char *t36;
    char *t37;
    int t38;
    unsigned int t39;
    char *t40;
    int t41;
    char *t42;
    char *t43;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t54;
    char *t55;
    char *t56;
    unsigned char t57;
    char *t58;
    int t59;
    int t60;
    char *t61;
    char *t62;
    unsigned char t63;

LAB0:    t6 = ((STD_TEXTIO) + 3440);
    t7 = (t3 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t9 = (t4 + 4U);
    t10 = xsi_create_file_variable_in_buffer(0, ng1, t6, t2, t8, 1);
    *((char **)t9) = t10;
    t11 = (t4 + 12U);
    t12 = ((STD_TEXTIO) + 3280);
    t13 = (t11 + 56U);
    *((char **)t13) = t12;
    t14 = (t11 + 40U);
    *((char **)t14) = 0;
    t15 = (t11 + 64U);
    *((int *)t15) = 1;
    t16 = (t11 + 48U);
    *((char **)t16) = 0;
    t18 = (t17 + 0U);
    t19 = (t18 + 0U);
    *((int *)t19) = 31;
    t19 = (t18 + 4U);
    *((int *)t19) = 0;
    t19 = (t18 + 8U);
    *((int *)t19) = -1;
    t20 = (0 - 31);
    t21 = (t20 * -1);
    t21 = (t21 + 1);
    t19 = (t18 + 12U);
    *((unsigned int *)t19) = t21;
    t19 = (t4 + 84U);
    t22 = (t1 + 5392);
    t23 = (t19 + 88U);
    *((char **)t23) = t22;
    t25 = (t19 + 56U);
    *((char **)t25) = t24;
    xsi_type_set_default_value(t22, t24, 0);
    t26 = (t19 + 64U);
    t27 = (t22 + 80U);
    t28 = *((char **)t27);
    *((char **)t26) = t28;
    t29 = (t19 + 80U);
    *((unsigned int *)t29) = 32U;
    t30 = xsi_get_transient_memory(32768U);
    memset(t30, 0, 32768U);
    t31 = t30;
    t21 = (32U * 1U);
    t32 = t31;
    memset(t32, (unsigned char)2, t21);
    t33 = (t21 != 0);
    if (t33 == 1)
        goto LAB2;

LAB3:    t36 = (t35 + 0U);
    t37 = (t36 + 0U);
    *((int *)t37) = 0;
    t37 = (t36 + 4U);
    *((int *)t37) = 1023;
    t37 = (t36 + 8U);
    *((int *)t37) = 1;
    t38 = (1023 - 0);
    t39 = (t38 * 1);
    t39 = (t39 + 1);
    t37 = (t36 + 12U);
    *((unsigned int *)t37) = t39;
    t37 = (t35 + 16U);
    t40 = (t37 + 0U);
    *((int *)t40) = 31;
    t40 = (t37 + 4U);
    *((int *)t40) = 0;
    t40 = (t37 + 8U);
    *((int *)t40) = -1;
    t41 = (0 - 31);
    t39 = (t41 * -1);
    t39 = (t39 + 1);
    t40 = (t37 + 12U);
    *((unsigned int *)t40) = t39;
    t40 = (t4 + 204U);
    t42 = (t1 + 5616);
    t43 = (t40 + 88U);
    *((char **)t43) = t42;
    t45 = (t40 + 56U);
    *((char **)t45) = t44;
    memcpy(t44, t30, 32768U);
    t46 = (t40 + 64U);
    t47 = (t42 + 80U);
    t48 = *((char **)t47);
    *((char **)t46) = t48;
    t49 = (t40 + 80U);
    *((unsigned int *)t49) = 32768U;
    t50 = (t4 + 324U);
    t51 = ((STD_STANDARD) + 384);
    t52 = (t50 + 88U);
    *((char **)t52) = t51;
    t54 = (t50 + 56U);
    *((char **)t54) = t53;
    xsi_type_set_default_value(t51, t53, 0);
    t55 = (t50 + 80U);
    *((unsigned int *)t55) = 4U;
    t56 = (t5 + 4U);
    t57 = (t2 != 0);
    if (t57 == 1)
        goto LAB5;

LAB4:    t58 = (t5 + 12U);
    *((char **)t58) = t3;
    t59 = 0;
    t60 = 1023;

LAB6:    if (t59 <= t60)
        goto LAB7;

LAB9:    t6 = (t40 + 56U);
    t7 = *((char **)t6);
    t33 = (32768U != 32768U);
    if (t33 == 1)
        goto LAB12;

LAB13:    t0 = xsi_get_transient_memory(32768U);
    memcpy(t0, t7, 32768U);

LAB1:    xsi_access_variable_delete(t11);
    t6 = (t4 + 4U);
    t7 = *((char **)t6);
    xsi_delete_file_variable(t7);
    return t0;
LAB2:    t34 = (32768U / t21);
    xsi_mem_set_data(t31, t31, t21, t34);
    goto LAB3;

LAB5:    *((char **)t56) = t2;
    goto LAB4;

LAB7:    t61 = (t4 + 4U);
    t62 = *((char **)t61);
    t63 = std_textio_endfile(t62);
    if (t63 != 0)
        goto LAB9;

LAB10:    t6 = (t4 + 4U);
    t7 = *((char **)t6);
    std_textio_readline(STD_TEXTIO, (char *)0, t7, t11);
    t6 = (t19 + 56U);
    t7 = *((char **)t6);
    ieee_p_3564397177_sub_3988856810_91900896(IEEE_P_3564397177, (char *)0, t11, t7, t17);
    t6 = (t19 + 56U);
    t7 = *((char **)t6);
    t6 = (t40 + 56U);
    t9 = *((char **)t6);
    t20 = (t59 - 0);
    t8 = (t20 * 1);
    xsi_vhdl_check_range_of_index(0, 1023, 1, t59);
    t21 = (32U * t8);
    t34 = (0 + t21);
    t6 = (t9 + t34);
    memcpy(t6, t7, 32U);

LAB8:    if (t59 == t60)
        goto LAB9;

LAB11:    t20 = (t59 + 1);
    t59 = t20;
    goto LAB6;

LAB12:    xsi_size_not_matching(32768U, 32768U, 0);
    goto LAB13;

LAB14:;
}

void work_a_2208116761_3212880686_sub_2048646809_3057020925(char *t0, char *t1, char *t2, char *t3, char *t4, unsigned int t5, unsigned int t6, char *t7, char *t8, unsigned int t9, unsigned int t10, char *t11, char *t12, unsigned int t13, unsigned int t14, char *t15, char *t16, unsigned int t17, unsigned int t18, char *t19)
{
    char t20[248];
    char t21[24];
    char t22[16];
    char t27[32];
    char t36[32];
    char t45[32768];
    char t51[16];
    char t57[32];
    char *t23;
    char *t24;
    int t25;
    unsigned int t26;
    char *t28;
    int t29;
    char *t30;
    int t31;
    char *t32;
    char *t33;
    unsigned char t34;
    unsigned int t35;
    char *t37;
    char *t38;
    int t39;
    unsigned int t40;
    char *t41;
    int t42;
    char *t43;
    char *t44;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t52;
    char *t53;
    int t54;
    char *t55;
    char *t56;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    unsigned char t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;

LAB0:    t23 = (t22 + 0U);
    t24 = (t23 + 0U);
    *((int *)t24) = 15;
    t24 = (t23 + 4U);
    *((int *)t24) = 0;
    t24 = (t23 + 8U);
    *((int *)t24) = -1;
    t25 = (0 - 15);
    t26 = (t25 * -1);
    t26 = (t26 + 1);
    t24 = (t23 + 12U);
    *((unsigned int *)t24) = t26;
    t24 = (t27 + 0U);
    t28 = (t24 + 0U);
    *((int *)t28) = 0;
    t28 = (t24 + 4U);
    *((int *)t28) = 1023;
    t28 = (t24 + 8U);
    *((int *)t28) = 1;
    t29 = (1023 - 0);
    t26 = (t29 * 1);
    t26 = (t26 + 1);
    t28 = (t24 + 12U);
    *((unsigned int *)t28) = t26;
    t28 = (t27 + 16U);
    t30 = (t28 + 0U);
    *((int *)t30) = 31;
    t30 = (t28 + 4U);
    *((int *)t30) = 0;
    t30 = (t28 + 8U);
    *((int *)t30) = -1;
    t31 = (0 - 31);
    t26 = (t31 * -1);
    t26 = (t26 + 1);
    t30 = (t28 + 12U);
    *((unsigned int *)t30) = t26;
    t30 = xsi_get_transient_memory(32768U);
    memset(t30, 0, 32768U);
    t32 = t30;
    t26 = (32U * 1U);
    t33 = t32;
    memset(t33, (unsigned char)0, t26);
    t34 = (t26 != 0);
    if (t34 == 1)
        goto LAB2;

LAB3:    t37 = (t36 + 0U);
    t38 = (t37 + 0U);
    *((int *)t38) = 0;
    t38 = (t37 + 4U);
    *((int *)t38) = 1023;
    t38 = (t37 + 8U);
    *((int *)t38) = 1;
    t39 = (1023 - 0);
    t40 = (t39 * 1);
    t40 = (t40 + 1);
    t38 = (t37 + 12U);
    *((unsigned int *)t38) = t40;
    t38 = (t36 + 16U);
    t41 = (t38 + 0U);
    *((int *)t41) = 31;
    t41 = (t38 + 4U);
    *((int *)t41) = 0;
    t41 = (t38 + 8U);
    *((int *)t41) = -1;
    t42 = (0 - 31);
    t40 = (t42 * -1);
    t40 = (t40 + 1);
    t41 = (t38 + 12U);
    *((unsigned int *)t41) = t40;
    t41 = (t20 + 4U);
    t43 = (t0 + 5616);
    t44 = (t41 + 88U);
    *((char **)t44) = t43;
    t46 = (t41 + 56U);
    *((char **)t46) = t45;
    memcpy(t45, t30, 32768U);
    t47 = (t41 + 64U);
    t48 = (t43 + 80U);
    t49 = *((char **)t48);
    *((char **)t47) = t49;
    t50 = (t41 + 80U);
    *((unsigned int *)t50) = 32768U;
    t52 = (t51 + 0U);
    t53 = (t52 + 0U);
    *((int *)t53) = 31;
    t53 = (t52 + 4U);
    *((int *)t53) = 0;
    t53 = (t52 + 8U);
    *((int *)t53) = -1;
    t54 = (0 - 31);
    t40 = (t54 * -1);
    t40 = (t40 + 1);
    t53 = (t52 + 12U);
    *((unsigned int *)t53) = t40;
    t53 = (t20 + 124U);
    t55 = (t0 + 5392);
    t56 = (t53 + 88U);
    *((char **)t56) = t55;
    t58 = (t53 + 56U);
    *((char **)t58) = t57;
    xsi_type_set_default_value(t55, t57, 0);
    t59 = (t53 + 64U);
    t60 = (t55 + 80U);
    t61 = *((char **)t60);
    *((char **)t59) = t61;
    t62 = (t53 + 80U);
    *((unsigned int *)t62) = 32U;
    t63 = (t21 + 4U);
    t64 = (t2 != 0);
    if (t64 == 1)
        goto LAB5;

LAB4:    t65 = (t21 + 12U);
    *((char **)t65) = t3;
    t66 = work_a_2208116761_3212880686_sub_4079585148_3057020925(t0, t2, t3);
    t67 = (t41 + 56U);
    t68 = *((char **)t67);
    t67 = (t68 + 0);
    memcpy(t67, t66, 32768U);
    t23 = (t41 + 56U);
    t24 = *((char **)t23);
    t26 = (0 + t17);
    t23 = (t19 + 56U);
    t28 = *((char **)t23);
    t30 = (t28 + 56U);
    t32 = *((char **)t30);
    memcpy(t32, t24, 32768U);
    xsi_driver_first_trans_delta(t19, t26, 32768U, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB9:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB10;

LAB11:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB7:
LAB8:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB6;
    else
        goto LAB9;

LAB2:    t35 = (32768U / t26);
    xsi_mem_set_data(t32, t32, t26, t35);
    goto LAB3;

LAB5:    *((char **)t63) = t2;
    goto LAB4;

LAB6:    xsi_remove_dynamic_wait(t1, t23);
    t26 = (0 + t5);
    t23 = (t7 + 56U);
    t24 = *((char **)t23);
    t28 = (t24 + 56U);
    t30 = *((char **)t28);
    *((unsigned char *)t30) = (unsigned char)3;
    xsi_driver_first_trans_delta(t7, t26, 1, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB15:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB16;

LAB17:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB13:
LAB14:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB12;
    else
        goto LAB15;

LAB10:    xsi_saveStackAndSuspend(t1);
    goto LAB11;

LAB12:    xsi_remove_dynamic_wait(t1, t23);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB21:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB22;

LAB23:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB19:
LAB20:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB18;
    else
        goto LAB21;

LAB16:    xsi_saveStackAndSuspend(t1);
    goto LAB17;

LAB18:    xsi_remove_dynamic_wait(t1, t23);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB27:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB28;

LAB29:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB25:
LAB26:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB24;
    else
        goto LAB27;

LAB22:    xsi_saveStackAndSuspend(t1);
    goto LAB23;

LAB24:    xsi_remove_dynamic_wait(t1, t23);
    t26 = (0 + t5);
    t23 = (t7 + 56U);
    t24 = *((char **)t23);
    t28 = (t24 + 56U);
    t30 = *((char **)t28);
    *((unsigned char *)t30) = (unsigned char)2;
    xsi_driver_first_trans_delta(t7, t26, 1, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB33:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB34;

LAB35:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB31:
LAB32:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB30;
    else
        goto LAB33;

LAB28:    xsi_saveStackAndSuspend(t1);
    goto LAB29;

LAB30:    xsi_remove_dynamic_wait(t1, t23);
    t25 = 0;
    t29 = 1023;

LAB36:    if (t25 <= t29)
        goto LAB37;

LAB39:    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB87:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB88;

LAB89:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB85:
LAB86:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB84;
    else
        goto LAB87;

LAB34:    xsi_saveStackAndSuspend(t1);
    goto LAB35;

LAB37:    t23 = (t0 + 2792U);
    t24 = *((char **)t23);
    t34 = *((unsigned char *)t24);
    t64 = (t34 == (unsigned char)3);
    if (t64 != 0)
        goto LAB39;

LAB40:    t23 = (t41 + 56U);
    t24 = *((char **)t23);
    t31 = (t25 - 0);
    t26 = (t31 * 1);
    xsi_vhdl_check_range_of_index(0, 1023, 1, t25);
    t35 = (32U * t26);
    t40 = (0 + t35);
    t23 = (t24 + t40);
    t28 = (t53 + 56U);
    t30 = *((char **)t28);
    t28 = (t30 + 0);
    memcpy(t28, t23, 32U);
    t23 = (t53 + 56U);
    t24 = *((char **)t23);
    t26 = (31 - 15);
    t35 = (t26 * 1U);
    t40 = (0 + t35);
    t23 = (t24 + t40);
    t69 = (0 + t9);
    t28 = (t11 + 56U);
    t30 = *((char **)t28);
    t32 = (t30 + 56U);
    t33 = *((char **)t32);
    t37 = (t22 + 12U);
    t70 = *((unsigned int *)t37);
    t70 = (t70 * 1U);
    memcpy(t33, t23, t70);
    t38 = (t22 + 12U);
    t71 = *((unsigned int *)t38);
    t72 = (1U * t71);
    xsi_driver_first_trans_delta(t11, t69, t72, 0LL);
    t26 = (0 + t13);
    t23 = (t15 + 56U);
    t24 = *((char **)t23);
    t28 = (t24 + 56U);
    t30 = *((char **)t28);
    *((unsigned char *)t30) = (unsigned char)3;
    xsi_driver_first_trans_delta(t15, t26, 1, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB44:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB45;

LAB46:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB42:
LAB43:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB41;
    else
        goto LAB44;

LAB38:    if (t25 == t29)
        goto LAB39;

LAB83:    t31 = (t25 + 1);
    t25 = t31;
    goto LAB36;

LAB41:    xsi_remove_dynamic_wait(t1, t23);
    t26 = (0 + t13);
    t23 = (t15 + 56U);
    t24 = *((char **)t23);
    t28 = (t24 + 56U);
    t30 = *((char **)t28);
    *((unsigned char *)t30) = (unsigned char)2;
    xsi_driver_first_trans_delta(t15, t26, 1, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB50:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB51;

LAB52:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB48:
LAB49:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB47;
    else
        goto LAB50;

LAB45:    xsi_saveStackAndSuspend(t1);
    goto LAB46;

LAB47:    xsi_remove_dynamic_wait(t1, t23);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB56:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB57;

LAB58:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB54:
LAB55:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB53;
    else
        goto LAB56;

LAB51:    xsi_saveStackAndSuspend(t1);
    goto LAB52;

LAB53:    xsi_remove_dynamic_wait(t1, t23);
    t23 = (t53 + 56U);
    t24 = *((char **)t23);
    t26 = (31 - 31);
    t35 = (t26 * 1U);
    t40 = (0 + t35);
    t23 = (t24 + t40);
    t69 = (0 + t9);
    t28 = (t11 + 56U);
    t30 = *((char **)t28);
    t32 = (t30 + 56U);
    t33 = *((char **)t32);
    t37 = (t22 + 12U);
    t70 = *((unsigned int *)t37);
    t70 = (t70 * 1U);
    memcpy(t33, t23, t70);
    t38 = (t22 + 12U);
    t71 = *((unsigned int *)t38);
    t72 = (1U * t71);
    xsi_driver_first_trans_delta(t11, t69, t72, 0LL);
    t26 = (0 + t13);
    t23 = (t15 + 56U);
    t24 = *((char **)t23);
    t28 = (t24 + 56U);
    t30 = *((char **)t28);
    *((unsigned char *)t30) = (unsigned char)3;
    xsi_driver_first_trans_delta(t15, t26, 1, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB62:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB63;

LAB64:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB60:
LAB61:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB59;
    else
        goto LAB62;

LAB57:    xsi_saveStackAndSuspend(t1);
    goto LAB58;

LAB59:    xsi_remove_dynamic_wait(t1, t23);
    t26 = (0 + t13);
    t23 = (t15 + 56U);
    t24 = *((char **)t23);
    t28 = (t24 + 56U);
    t30 = *((char **)t28);
    *((unsigned char *)t30) = (unsigned char)2;
    xsi_driver_first_trans_delta(t15, t26, 1, 0LL);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB68:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB69;

LAB70:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB66:
LAB67:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB65;
    else
        goto LAB68;

LAB63:    xsi_saveStackAndSuspend(t1);
    goto LAB64;

LAB65:    xsi_remove_dynamic_wait(t1, t23);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB74:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB75;

LAB76:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB72:
LAB73:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB71;
    else
        goto LAB74;

LAB69:    xsi_saveStackAndSuspend(t1);
    goto LAB70;

LAB71:    xsi_remove_dynamic_wait(t1, t23);
    t23 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t23, -1, -1);

LAB80:    t24 = (t1 + 224U);
    t24 = *((char **)t24);
    xsi_wp_set_status(t24, 1);
    t28 = (t1 + 88U);
    t30 = *((char **)t28);
    t32 = (t30 + 2480U);
    *((unsigned int *)t32) = 1U;
    t33 = (t1 + 88U);
    t37 = *((char **)t33);
    t38 = (t37 + 0U);
    getcontext(t38);
    t43 = (t1 + 88U);
    t44 = *((char **)t43);
    t46 = (t44 + 2480U);
    t26 = *((unsigned int *)t46);
    if (t26 == 1)
        goto LAB81;

LAB82:    t47 = (t1 + 88U);
    t48 = *((char **)t47);
    t49 = (t48 + 2480U);
    *((unsigned int *)t49) = 3U;

LAB78:
LAB79:    t50 = (t0 + 1152U);
    t34 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t50, 0U, 0U);
    if (t34 == 1)
        goto LAB77;
    else
        goto LAB80;

LAB75:    xsi_saveStackAndSuspend(t1);
    goto LAB76;

LAB77:    xsi_remove_dynamic_wait(t1, t23);
    goto LAB38;

LAB81:    xsi_saveStackAndSuspend(t1);
    goto LAB82;

LAB84:    xsi_remove_dynamic_wait(t1, t23);

LAB1:    return;
LAB88:    xsi_saveStackAndSuspend(t1);
    goto LAB89;

}

void work_a_2208116761_3212880686_sub_3514163766_3057020925(char *t0, char *t1)
{
    int t4;
    int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned char t22;
    int t23;

LAB0:    t4 = 0;
    t5 = 31;

LAB2:    if (t4 <= t5)
        goto LAB3;

LAB5:
LAB1:    return;
LAB3:    t6 = (t0 + 1152U);
    xsi_add_dynamic_wait(t1, t6, -1, -1);

LAB9:    t7 = (t1 + 224U);
    t7 = *((char **)t7);
    xsi_wp_set_status(t7, 1);
    t8 = (t1 + 88U);
    t9 = *((char **)t8);
    t10 = (t9 + 2480U);
    *((unsigned int *)t10) = 1U;
    t11 = (t1 + 88U);
    t12 = *((char **)t11);
    t13 = (t12 + 0U);
    getcontext(t13);
    t14 = (t1 + 88U);
    t15 = *((char **)t14);
    t16 = (t15 + 2480U);
    t17 = *((unsigned int *)t16);
    if (t17 == 1)
        goto LAB10;

LAB11:    t18 = (t1 + 88U);
    t19 = *((char **)t18);
    t20 = (t19 + 2480U);
    *((unsigned int *)t20) = 3U;

LAB7:
LAB8:    t21 = (t0 + 1152U);
    t22 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t21, 0U, 0U);
    if (t22 == 1)
        goto LAB6;
    else
        goto LAB9;

LAB4:    if (t4 == t5)
        goto LAB5;

LAB12:    t23 = (t4 + 1);
    t4 = t23;
    goto LAB2;

LAB6:    xsi_remove_dynamic_wait(t1, t6);
    goto LAB4;

LAB10:    xsi_saveStackAndSuspend(t1);
    goto LAB11;

}

static void work_a_2208116761_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    int64 t9;
    int64 t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 4232U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(150, ng5);
    t2 = (t0 + 4864);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_delta(t2, 0U, 1, 0LL);
    t7 = (t0 + 3248U);
    t8 = *((char **)t7);
    t9 = *((int64 *)t8);
    t10 = (t9 / 2);
    t7 = (t0 + 4864);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_subsequent_trans_delta(t7, 0U, 1, t10);
    xsi_set_current_line(151, ng5);
    t2 = (t0 + 3248U);
    t3 = *((char **)t2);
    t9 = *((int64 *)t3);
    t2 = (t0 + 4040);
    xsi_process_wait(t2, t9);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

}

static void work_a_2208116761_3212880686_p_1(char *t0)
{
    char t5[16];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int64 t17;

LAB0:    t1 = (t0 + 4480U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(157, ng5);
    t2 = (t0 + 4288);
    t3 = (t0 + 41200);
    t6 = (t5 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 1;
    t7 = (t6 + 4U);
    *((int *)t7) = 21;
    t7 = (t6 + 8U);
    *((int *)t7) = 1;
    t8 = (21 - 1);
    t9 = (t8 * 1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t7 = (t0 + 1312U);
    t10 = (t0 + 5056);
    t11 = (t0 + 1472U);
    t12 = (t0 + 5120);
    t13 = (t0 + 2272U);
    t14 = (t0 + 4928);
    t15 = (t0 + 992U);
    t16 = (t0 + 4992);
    work_a_2208116761_3212880686_sub_2048646809_3057020925(t0, t2, t3, t5, t7, 0U, 0U, t10, t11, 0U, 0U, t12, t13, 0U, 0U, t14, t15, 0U, 0U, t16);
    xsi_set_current_line(158, ng5);
    t17 = (300 * 1000LL);
    t2 = (t0 + 4288);
    xsi_process_wait(t2, t17);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(160, ng5);
    t2 = (t0 + 4288);
    t3 = (t0 + 41221);
    t6 = (t5 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 1;
    t7 = (t6 + 4U);
    *((int *)t7) = 25;
    t7 = (t6 + 8U);
    *((int *)t7) = 1;
    t8 = (25 - 1);
    t9 = (t8 * 1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t7 = (t0 + 1312U);
    t10 = (t0 + 5056);
    t11 = (t0 + 1472U);
    t12 = (t0 + 5120);
    t13 = (t0 + 2272U);
    t14 = (t0 + 4928);
    t15 = (t0 + 992U);
    t16 = (t0 + 4992);
    work_a_2208116761_3212880686_sub_2048646809_3057020925(t0, t2, t3, t5, t7, 0U, 0U, t10, t11, 0U, 0U, t12, t13, 0U, 0U, t14, t15, 0U, 0U, t16);
    xsi_set_current_line(161, ng5);
    t17 = (1000 * 1000LL);
    t2 = (t0 + 4288);
    xsi_process_wait(t2, t17);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}


void ieee_p_2592010699_sub_3130575329_503743352();

extern void work_a_2208116761_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2208116761_3212880686_p_0,(void *)work_a_2208116761_3212880686_p_1};
	static char *se[] = {(void *)work_a_2208116761_3212880686_sub_4079585148_3057020925,(void *)work_a_2208116761_3212880686_sub_2048646809_3057020925,(void *)work_a_2208116761_3212880686_sub_3514163766_3057020925};
	xsi_register_didat("work_a_2208116761_3212880686", "isim/cpu_top_tb_isim_beh.exe.sim/work/a_2208116761_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 3);
}
