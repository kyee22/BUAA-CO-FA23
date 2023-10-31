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
static const char *ng0 = "E:/CO/co-lab/P4_PW/NPC.v";
static int ng1[] = {4, 0};
static int ng2[] = {0, 0};
static int ng3[] = {1, 0};
static int ng4[] = {2, 0};
static unsigned int ng5[] = {0U, 0U};
static int ng6[] = {3, 0};



static void Cont_32_0(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 32, t3, 32, t2, 32);
    t5 = (t0 + 3992);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 8);
    xsi_driver_vfirst_trans(t5, 0, 31);
    t10 = (t0 + 3896);
    *((int *)t10) = 1;

LAB1:    return;
}

static void Always_35_1(char *t0)
{
    char t9[8];
    char t11[8];
    char t12[8];
    char t38[8];
    char t41[8];
    char t42[8];
    char t49[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t10;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t39;
    char *t40;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    char *t48;
    char *t50;

LAB0:    t1 = (t0 + 3576U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 3912);
    *((int *)t2) = 1;
    t3 = (t0 + 3608);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(35, ng0);

LAB5:    xsi_set_current_line(36, ng0);
    t4 = (t0 + 1848U);
    t5 = *((char **)t4);

LAB6:    t4 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 8, t4, 32);
    if (t6 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng3)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 8, t2, 32);
    if (t6 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng4)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 8, t2, 32);
    if (t6 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng6)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 8, t2, 32);
    if (t6 == 1)
        goto LAB13;

LAB14:
LAB15:    goto LAB2;

LAB7:    xsi_set_current_line(38, ng0);

LAB16:    xsi_set_current_line(39, ng0);
    t7 = (t0 + 1048U);
    t8 = *((char **)t7);
    t7 = ((char*)((ng1)));
    memset(t9, 0, 8);
    xsi_vlog_unsigned_add(t9, 32, t8, 32, t7, 32);
    t10 = (t0 + 2408);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);
    goto LAB15;

LAB9:    xsi_set_current_line(43, ng0);

LAB17:    xsi_set_current_line(44, ng0);
    t3 = (t0 + 1528U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng3)));
    memset(t12, 0, 8);
    t7 = (t4 + 4);
    t8 = (t3 + 4);
    t13 = *((unsigned int *)t4);
    t14 = *((unsigned int *)t3);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t7);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB21;

LAB18:    if (t22 != 0)
        goto LAB20;

LAB19:    *((unsigned int *)t12) = 1;

LAB21:    memset(t11, 0, 8);
    t25 = (t12 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t12);
    t29 = (t28 & t27);
    t30 = (t29 & 1U);
    if (t30 != 0)
        goto LAB22;

LAB23:    if (*((unsigned int *)t25) != 0)
        goto LAB24;

LAB25:    t32 = (t11 + 4);
    t33 = *((unsigned int *)t11);
    t34 = *((unsigned int *)t32);
    t35 = (t33 || t34);
    if (t35 > 0)
        goto LAB26;

LAB27:    t43 = *((unsigned int *)t11);
    t44 = (~(t43));
    t45 = *((unsigned int *)t32);
    t46 = (t44 || t45);
    if (t46 > 0)
        goto LAB28;

LAB29:    if (*((unsigned int *)t32) > 0)
        goto LAB30;

LAB31:    if (*((unsigned int *)t11) > 0)
        goto LAB32;

LAB33:    memcpy(t9, t49, 8);

LAB34:    t50 = (t0 + 2408);
    xsi_vlogvar_assign_value(t50, t9, 0, 0, 32);
    goto LAB15;

LAB11:    xsi_set_current_line(48, ng0);

LAB35:    xsi_set_current_line(49, ng0);
    t3 = ((char*)((ng5)));
    t4 = (t0 + 1368U);
    t7 = *((char **)t4);
    t4 = (t0 + 1048U);
    t8 = *((char **)t4);
    memset(t12, 0, 8);
    t4 = (t12 + 4);
    t10 = (t8 + 4);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 28);
    *((unsigned int *)t12) = t14;
    t15 = *((unsigned int *)t10);
    t16 = (t15 >> 28);
    *((unsigned int *)t4) = t16;
    t17 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t17 & 15U);
    t18 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t18 & 15U);
    xsi_vlogtype_concat(t11, 4, 4, 1U, t12, 4);
    xsi_vlogtype_concat(t9, 32, 32, 3U, t11, 4, t7, 26, t3, 2);
    t25 = (t0 + 2408);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB15;

LAB13:    xsi_set_current_line(53, ng0);

LAB36:    xsi_set_current_line(54, ng0);
    t3 = (t0 + 1688U);
    t4 = *((char **)t3);
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t4, 0, 0, 32);
    goto LAB15;

LAB20:    t10 = (t12 + 4);
    *((unsigned int *)t12) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB21;

LAB22:    *((unsigned int *)t11) = 1;
    goto LAB25;

LAB24:    t31 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t31) = 1;
    goto LAB25;

LAB26:    t36 = (t0 + 1048U);
    t37 = *((char **)t36);
    t36 = ((char*)((ng1)));
    memset(t38, 0, 8);
    xsi_vlog_unsigned_add(t38, 32, t37, 32, t36, 32);
    t39 = (t0 + 1208U);
    t40 = *((char **)t39);
    t39 = ((char*)((ng4)));
    memset(t41, 0, 8);
    xsi_vlog_unsigned_lshift(t41, 32, t40, 32, t39, 32);
    memset(t42, 0, 8);
    xsi_vlog_unsigned_add(t42, 32, t38, 32, t41, 32);
    goto LAB27;

LAB28:    t47 = (t0 + 1048U);
    t48 = *((char **)t47);
    t47 = ((char*)((ng1)));
    memset(t49, 0, 8);
    xsi_vlog_unsigned_add(t49, 32, t48, 32, t47, 32);
    goto LAB29;

LAB30:    xsi_vlog_unsigned_bit_combine(t9, 32, t42, 32, t49, 32);
    goto LAB34;

LAB32:    memcpy(t9, t42, 8);
    goto LAB34;

}


extern void work_m_00000000003888649371_0757879789_init()
{
	static char *pe[] = {(void *)Cont_32_0,(void *)Always_35_1};
	xsi_register_didat("work_m_00000000003888649371_0757879789", "isim/mips_tb_isim_beh.exe.sim/work/m_00000000003888649371_0757879789.didat");
	xsi_register_executes(pe);
}
