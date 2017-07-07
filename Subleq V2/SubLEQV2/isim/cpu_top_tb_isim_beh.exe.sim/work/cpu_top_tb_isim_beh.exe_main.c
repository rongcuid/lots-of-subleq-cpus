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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *WORK_P_3913243728;
char *IEEE_P_3564397177;
char *IEEE_P_1242562249;
char *STD_TEXTIO;
char *IEEE_P_2592010699;
char *STD_STANDARD;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    std_textio_init();
    ieee_p_1242562249_init();
    ieee_p_3564397177_init();
    work_p_3913243728_init();
    work_a_1415465652_3212880686_init();
    work_a_1948002761_0000452272_init();
    work_a_3027833369_3212880686_init();
    work_a_3564661738_3212880686_init();
    work_a_1745933882_3212880686_init();
    work_a_2208116761_3212880686_init();


    xsi_register_tops("work_a_2208116761_3212880686");

    WORK_P_3913243728 = xsi_get_engine_memory("work_p_3913243728");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");

    return xsi_run_simulation(argc, argv);

}
