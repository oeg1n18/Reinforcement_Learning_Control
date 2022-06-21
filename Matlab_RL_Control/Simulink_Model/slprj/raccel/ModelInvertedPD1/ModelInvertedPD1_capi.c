#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "ModelInvertedPD1_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)    
#else
#include "builtin_typeid_types.h"
#include "ModelInvertedPD1.h"
#include "ModelInvertedPD1_capi.h"
#include "ModelInvertedPD1_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST                  
#define TARGET_STRING(s)               (NULL)                    
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/Add" ) , TARGET_STRING ( ""
) , 0 , 0 , 0 , 0 , 0 } , { 1 , 0 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/Add2" ) , TARGET_STRING (
"" ) , 0 , 0 , 0 , 0 , 0 } , { 2 , 0 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/Add3" ) , TARGET_STRING (
"" ) , 0 , 0 , 0 , 0 , 0 } , { 3 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/theta_0" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 1 } , { 4 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 5 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator1" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 6 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator2" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 7 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator3" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 8 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Divide" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 9 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Divide1" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 10 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Add2" ) , TARGET_STRING
( "" ) , 0 , 0 , 0 , 0 , 1 } , { 11 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Add4" ) , TARGET_STRING
( "" ) , 0 , 0 , 0 , 0 , 1 } , { 12 , 0 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Unit Delay" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 2 } , { 13 , 0 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller/D" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 14 , 0 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller1/D" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 0 , 0 , ( NULL ) , ( NULL ) ,
0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_BlockParameters
rtBlockParameters [ ] = { { 15 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"m" ) , 0 , 0 , 0 } , { 16 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"cM" ) , 0 , 0 , 0 } , { 17 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"L" ) , 0 , 0 , 0 } , { 18 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"g" ) , 0 , 0 , 0 } , { 19 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"I" ) , 0 , 0 , 0 } , { 20 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"theta0" ) , 0 , 0 , 0 } , { 21 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"cart_friction" ) , 0 , 0 , 0 } , { 22 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model" ) , TARGET_STRING (
"pend_damp" ) , 0 , 0 , 0 } , { 23 , TARGET_STRING (
"ModelInvertedPD1/angle set point" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0
} , { 24 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller" ) ,
TARGET_STRING ( "P" ) , 0 , 0 , 0 } , { 25 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller" ) ,
TARGET_STRING ( "D" ) , 0 , 0 , 0 } , { 26 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller1" ) ,
TARGET_STRING ( "P" ) , 0 , 0 , 0 } , { 27 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller1" ) ,
TARGET_STRING ( "D" ) , 0 , 0 , 0 } , { 28 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/position set point" ) ,
TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 29 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/Gain" ) , TARGET_STRING (
"Gain" ) , 0 , 0 , 0 } , { 30 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/Gain1" ) , TARGET_STRING (
"Gain" ) , 0 , 0 , 0 } , { 31 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/voltage to force" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 32 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator" ) ,
TARGET_STRING ( "InitialCondition" ) , 0 , 0 , 0 } , { 33 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator1" ) ,
TARGET_STRING ( "InitialCondition" ) , 0 , 0 , 0 } , { 34 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator2" ) ,
TARGET_STRING ( "InitialCondition" ) , 0 , 0 , 0 } , { 35 , TARGET_STRING (
"ModelInvertedPD1/Pendulum with simple DC motor model/Unit Delay" ) ,
TARGET_STRING ( "InitialCondition" ) , 0 , 0 , 0 } , { 36 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller/Integral" )
, TARGET_STRING ( "A" ) , 0 , 0 , 0 } , { 37 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller/Integral" )
, TARGET_STRING ( "C" ) , 0 , 0 , 0 } , { 38 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller1/Integral" )
, TARGET_STRING ( "A" ) , 0 , 0 , 0 } , { 39 , TARGET_STRING (
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller1/Integral" )
, TARGET_STRING ( "C" ) , 0 , 0 , 0 } , { 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0
} } ; static const rtwCAPI_Signals rtRootInputs [ ] = { { 0 , 0 , ( NULL ) ,
( NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_Signals rtRootOutputs
[ ] = { { 40 , 0 , TARGET_STRING ( "ModelInvertedPD1/Out1" ) , TARGET_STRING
( "angle" ) , 1 , 0 , 0 , 0 , 0 } , { 41 , 0 , TARGET_STRING (
"ModelInvertedPD1/Out2" ) , TARGET_STRING ( "position" ) , 2 , 0 , 0 , 0 , 0
} , { 42 , 0 , TARGET_STRING ( "ModelInvertedPD1/Out3" ) , TARGET_STRING (
"control" ) , 3 , 0 , 0 , 0 , 0 } , { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0
, 0 , 0 } } ; static const rtwCAPI_ModelParameters rtModelParameters [ ] = {
{ 0 , ( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . j5pjftq3nr , & rtB . gkd5hkbora ,
& rtB . luhxo3sjcz , & rtB . kavhf2n2dt , & rtB . p234tnqihm , & rtB .
kcgo5pdtwx , & rtB . na0hnm0ahn , & rtB . mqldei4mxm , & rtB . di5ykdprrn , &
rtB . b3p20auilt , & rtB . m35hwgvkjs , & rtB . ptqflg33mj , & rtB .
krvnj1tdvz , & rtB . nd41acnict , & rtB . ecpggtixws , & rtP .
PendulumwithsimpleDCmotormodel_m , & rtP . PendulumwithsimpleDCmotormodel_cM
, & rtP . PendulumwithsimpleDCmotormodel_L , & rtP .
PendulumwithsimpleDCmotormodel_g , & rtP . PendulumwithsimpleDCmotormodel_I ,
& rtP . PendulumwithsimpleDCmotormodel_theta0 , & rtP .
PendulumwithsimpleDCmotormodel_cart_friction , & rtP .
PendulumwithsimpleDCmotormodel_pend_damp , & rtP . anglesetpoint_Value , &
rtP . PIDController_P , & rtP . PIDController_D , & rtP . PIDController1_P ,
& rtP . PIDController1_D , & rtP . positionsetpoint_Value , & rtP . Gain_Gain
, & rtP . Gain1_Gain , & rtP . voltagetoforce_Gain , & rtP . Integrator_IC ,
& rtP . Integrator1_IC , & rtP . Integrator2_IC , & rtP .
UnitDelay_InitialCondition , & rtP . Integral_A_k15zlijgrn , & rtP .
Integral_C_ba5drzgqpp , & rtP . Integral_A , & rtP . Integral_C , & rtY .
cshogg3pxi , & rtY . gtmzuvksgc , & rtY . dam3gsto5g , } ; static int32_T *
rtVarDimsAddrMap [ ] = { ( NULL ) } ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , SS_DOUBLE , 0 , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } } ; static const uint_T rtDimensionArray [ ] = {
1 , 1 } ; static const real_T rtcapiStoredFloats [ ] = { 0.0 , 0.001 } ;
static const rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) ,
rtwCAPI_FIX_RESERVED , 0 , 0 , 0 } , } ; static const rtwCAPI_SampleTimeMap
rtSampleTimeMap [ ] = { { ( const void * ) & rtcapiStoredFloats [ 0 ] , (
const void * ) & rtcapiStoredFloats [ 0 ] , 0 , 0 } , { ( NULL ) , ( NULL ) ,
2 , 0 } , { ( const void * ) & rtcapiStoredFloats [ 1 ] , ( const void * ) &
rtcapiStoredFloats [ 0 ] , 1 , 0 } } ; static rtwCAPI_ModelMappingStaticInfo
mmiStatic = { { rtBlockSignals , 15 , rtRootInputs , 0 , rtRootOutputs , 3 }
, { rtBlockParameters , 25 , rtModelParameters , 0 } , { ( NULL ) , 0 } , {
rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap , rtSampleTimeMap
, rtDimensionArray } , "float" , { 2343522158U , 371102075U , 323406722U ,
1538438267U } , ( NULL ) , 0 , 0 } ; const rtwCAPI_ModelMappingStaticInfo *
ModelInvertedPD1_GetCAPIStaticMap ( void ) { return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void ModelInvertedPD1_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( (
* rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void ModelInvertedPD1_host_InitializeDataMapInfo (
ModelInvertedPD1_host_DataMapInfo_T * dataMap , const char * path ) {
rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ; rtwCAPI_SetStaticMap ( dataMap ->
mmi , & mmiStatic ) ; rtwCAPI_SetDataAddressMap ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , NULL ) ; rtwCAPI_SetPath (
dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
