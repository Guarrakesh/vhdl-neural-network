/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern void execute_89(char*, char *);
extern void execute_37(char*, char *);
extern void execute_40(char*, char *);
extern void execute_43(char*, char *);
extern void execute_46(char*, char *);
extern void execute_49(char*, char *);
extern void execute_52(char*, char *);
extern void execute_55(char*, char *);
extern void execute_58(char*, char *);
extern void execute_61(char*, char *);
extern void execute_64(char*, char *);
extern void execute_69(char*, char *);
extern void execute_72(char*, char *);
extern void execute_75(char*, char *);
extern void execute_78(char*, char *);
extern void execute_81(char*, char *);
extern void execute_84(char*, char *);
extern void execute_87(char*, char *);
funcp funcTab[18] = {(funcp)execute_89, (funcp)execute_37, (funcp)execute_40, (funcp)execute_43, (funcp)execute_46, (funcp)execute_49, (funcp)execute_52, (funcp)execute_55, (funcp)execute_58, (funcp)execute_61, (funcp)execute_64, (funcp)execute_69, (funcp)execute_72, (funcp)execute_75, (funcp)execute_78, (funcp)execute_81, (funcp)execute_84, (funcp)execute_87};
const int NumRelocateId= 18;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb2_behav/xsim.reloc",  (void **)funcTab, 18);
	iki_vhdl_file_variable_register(dp + 4016);
	iki_vhdl_file_variable_register(dp + 4072);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb2_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb2_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb2_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb2_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb2_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
