#ifndef RTW_HEADER_ModelInvertedPD1_h_
#define RTW_HEADER_ModelInvertedPD1_h_
#include <stddef.h>
#include <string.h>
#include "rtw_modelmap.h"
#ifndef ModelInvertedPD1_COMMON_INCLUDES_
#define ModelInvertedPD1_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "ModelInvertedPD1_types.h"
#include "multiword_types.h"
#include "rtGetInf.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"
#include "rt_defines.h"
#define MODEL_NAME ModelInvertedPD1
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (3)     
#define NBLOCKIO (15) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (6)   
#elif NCSTATES != 6
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T mqldei4mxm ; real_T kcgo5pdtwx ; real_T gkd5hkbora ;
real_T ecpggtixws ; real_T j5pjftq3nr ; real_T nd41acnict ; real_T luhxo3sjcz
; real_T na0hnm0ahn ; real_T krvnj1tdvz ; real_T b3p20auilt ; real_T
p234tnqihm ; real_T di5ykdprrn ; real_T m35hwgvkjs ; real_T ptqflg33mj ;
real_T kavhf2n2dt ; } B ; typedef struct { real_T hcfky4ne0s ; real_T
pqewfscbbz ; real_T j0dwbzuyks ; real_T jmqcdoq5yq ; real_T fgimvn0lfv ;
real_T b1ongj3jd4 ; real_T imu0ukszsd ; real_T llmahncqtr ; real_T bczs4gywqv
; struct { void * LoggedData [ 3 ] ; } fop0wnjdpc ; int_T bygdd4hn3h ; } DW ;
typedef struct { real_T fqq1sxonv5 ; real_T c3z3c33bnj ; real_T dabk3wvnps ;
real_T divdvbvhoq ; real_T nl0fba1ca3 ; real_T khq5j2xzhz ; } X ; typedef
struct { real_T fqq1sxonv5 ; real_T c3z3c33bnj ; real_T dabk3wvnps ; real_T
divdvbvhoq ; real_T nl0fba1ca3 ; real_T khq5j2xzhz ; } XDot ; typedef struct
{ boolean_T fqq1sxonv5 ; boolean_T c3z3c33bnj ; boolean_T dabk3wvnps ;
boolean_T divdvbvhoq ; boolean_T nl0fba1ca3 ; boolean_T khq5j2xzhz ; } XDis ;
typedef struct { real_T fqq1sxonv5 ; real_T c3z3c33bnj ; real_T dabk3wvnps ;
real_T divdvbvhoq ; real_T nl0fba1ca3 ; real_T khq5j2xzhz ; } CStateAbsTol ;
typedef struct { real_T fqq1sxonv5 ; real_T c3z3c33bnj ; real_T dabk3wvnps ;
real_T divdvbvhoq ; real_T nl0fba1ca3 ; real_T khq5j2xzhz ; } CXPtMin ;
typedef struct { real_T fqq1sxonv5 ; real_T c3z3c33bnj ; real_T dabk3wvnps ;
real_T divdvbvhoq ; real_T nl0fba1ca3 ; real_T khq5j2xzhz ; } CXPtMax ;
typedef struct { real_T cshogg3pxi ; real_T gtmzuvksgc ; real_T dam3gsto5g ;
} ExtY ; typedef struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ;
struct P_ { real_T PIDController1_D ; real_T PIDController_D ; real_T
PendulumwithsimpleDCmotormodel_I ; real_T PendulumwithsimpleDCmotormodel_L ;
real_T PIDController1_P ; real_T PIDController_P ; real_T
PendulumwithsimpleDCmotormodel_cM ; real_T
PendulumwithsimpleDCmotormodel_cart_friction ; real_T
PendulumwithsimpleDCmotormodel_g ; real_T PendulumwithsimpleDCmotormodel_m ;
real_T PendulumwithsimpleDCmotormodel_pend_damp ; real_T
PendulumwithsimpleDCmotormodel_theta0 ; real_T Integrator1_IC ; real_T
Integral_A ; real_T Integral_C ; real_T Gain_Gain ; real_T
Integral_A_k15zlijgrn ; real_T Integral_C_ba5drzgqpp ; real_T Gain1_Gain ;
real_T voltagetoforce_Gain ; real_T Integrator2_IC ; real_T
UnitDelay_InitialCondition ; real_T Integrator_IC ; real_T
positionsetpoint_Value ; real_T anglesetpoint_Value ; } ; extern const char *
RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern X rtX ; extern DW rtDW ;
extern ExtY rtY ; extern P rtP ; extern const rtwCAPI_ModelMappingStaticInfo
* ModelInvertedPD1_GetCAPIStaticMap ( void ) ; extern SimStruct * const rtS ;
extern const int_T gblNumToFiles ; extern const int_T gblNumFrFiles ; extern
const int_T gblNumFrWksBlocks ; extern rtInportTUtable * gblInportTUtables ;
extern const char * gblInportFileName ; extern const int_T
gblNumRootInportBlks ; extern const int_T gblNumModelInputs ; extern const
int_T gblInportDataTypeIdx [ ] ; extern const int_T gblInportDims [ ] ;
extern const int_T gblInportComplex [ ] ; extern const int_T
gblInportInterpoFlag [ ] ; extern const int_T gblInportContinuous [ ] ;
extern const int_T gblParameterTuningTid ; extern DataMapInfo *
rt_dataMapInfoPtr ; extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ;
void MdlOutputs ( int_T tid ) ; void MdlOutputsParameterSampleTime ( int_T
tid ) ; void MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void
MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ;
SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) ;
#endif
