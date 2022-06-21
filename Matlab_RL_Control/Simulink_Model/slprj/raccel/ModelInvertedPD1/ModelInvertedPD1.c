#include "rt_logging_mmi.h"
#include "ModelInvertedPD1_capi.h"
#include <math.h>
#include "ModelInvertedPD1.h"
#include "ModelInvertedPD1_private.h"
#include "ModelInvertedPD1_dt.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "slsa_sim_engine.h"
extern void * CreateDiagnosticAsVoidPtr_wrapper ( const char * id , int nargs
, ... ) ; RTWExtModeInfo * gblRTWExtModeInfo = NULL ; void
raccelForceExtModeShutdown ( boolean_T extModeStartPktReceived ) { if ( !
extModeStartPktReceived ) { boolean_T stopRequested = false ;
rtExtModeWaitForStartPkt ( gblRTWExtModeInfo , 2 , & stopRequested ) ; }
rtExtModeShutdown ( 2 ) ; }
#include "slsv_diagnostic_codegen_c_api.h"
const int_T gblNumToFiles = 0 ; const int_T gblNumFrFiles = 0 ; const int_T
gblNumFrWksBlocks = 0 ;
#ifdef RSIM_WITH_SOLVER_MULTITASKING
boolean_T gbl_raccel_isMultitasking = 1 ;
#else
boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
boolean_T gbl_raccel_tid01eq = 0 ; int_T gbl_raccel_NumST = 3 ; const char_T
* gbl_raccel_Version = "10.2 (R2020b) 29-Jul-2020" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#else
UNUSED_PARAMETER ( S ) ;
#endif
} static DataMapInfo rt_dataMapInfo ; DataMapInfo * rt_dataMapInfoPtr = &
rt_dataMapInfo ; rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; const int_T gblNumRootInportBlks = 0 ; const int_T
gblNumModelInputs = 0 ; extern const char * gblInportFileName ; extern
rtInportTUtable * gblInportTUtables ; const int_T gblInportDataTypeIdx [ ] =
{ - 1 } ; const int_T gblInportDims [ ] = { - 1 } ; const int_T
gblInportComplex [ ] = { - 1 } ; const int_T gblInportInterpoFlag [ ] = { - 1
} ; const int_T gblInportContinuous [ ] = { - 1 } ; int_T enableFcnCallFlag [
] = { 1 , 1 , 1 } ; const char * raccelLoadInputsAndAperiodicHitTimes (
SimStruct * S , const char * inportFileName , int * matFileFormat ) { return
rt_RAccelReadInportsMatFile ( S , inportFileName , matFileFormat ) ; } B rtB
; X rtX ; DW rtDW ; ExtY rtY ; static SimStruct model_S ; SimStruct * const
rtS = & model_S ; void MdlInitialize ( void ) { boolean_T tmp ; rtDW .
bygdd4hn3h = 1 ; if ( ssIsFirstInitCond ( rtS ) ) { rtX . fqq1sxonv5 = 0.2 ;
tmp = slIsRapidAcceleratorSimulating ( ) ; if ( tmp ) { tmp =
ssGetGlobalInitialStatesAvailable ( rtS ) ; rtDW . bygdd4hn3h = ! tmp ; }
else { rtDW . bygdd4hn3h = 1 ; } } rtX . c3z3c33bnj = rtP . Integrator1_IC ;
rtX . dabk3wvnps = 0.0 ; rtDW . pqewfscbbz = ( rtInf ) ; rtDW . jmqcdoq5yq =
( rtInf ) ; rtX . divdvbvhoq = 0.0 ; rtDW . b1ongj3jd4 = ( rtInf ) ; rtDW .
llmahncqtr = ( rtInf ) ; rtX . nl0fba1ca3 = rtP . Integrator2_IC ; rtDW .
hcfky4ne0s = rtP . UnitDelay_InitialCondition ; rtX . khq5j2xzhz = rtP .
Integrator_IC ; } void MdlStart ( void ) { { bool
externalInputIsInDatasetFormat = false ; void * pISigstreamManager =
rt_GetISigstreamManager ( rtS ) ;
rtwISigstreamManagerGetInputIsInDatasetFormat ( pISigstreamManager , &
externalInputIsInDatasetFormat ) ; if ( externalInputIsInDatasetFormat ) { }
} { RTWLogSignalInfo rt_ScopeSignalInfo ; static int_T rt_ScopeSignalWidths [
] = { 1 , 1 , 1 } ; static int_T rt_ScopeSignalNumDimensions [ ] = { 1 , 1 ,
1 } ; static int_T rt_ScopeSignalDimensions [ ] = { 1 , 1 , 1 } ; static void
* rt_ScopeCurrSigDims [ ] = { ( NULL ) , ( NULL ) , ( NULL ) } ; static int_T
rt_ScopeCurrSigDimsSize [ ] = { 4 , 4 , 4 } ; static const char_T *
rt_ScopeSignalLabels [ ] = { "position" , "angle" , "control" } ; static
char_T rt_ScopeSignalTitles [ ] = "positionanglecontrol" ; static int_T
rt_ScopeSignalTitleLengths [ ] = { 8 , 5 , 7 } ; static boolean_T
rt_ScopeSignalIsVarDims [ ] = { 0 , 0 , 0 } ; static int_T
rt_ScopeSignalPlotStyles [ ] = { 0 , 0 , 0 } ; BuiltInDTypeId dTypes [ 3 ] =
{ SS_DOUBLE , SS_DOUBLE , SS_DOUBLE } ; static char_T rt_ScopeBlockName [ ] =
"ModelInvertedPD1/Scope" ; static int_T rt_ScopeFrameData [ ] = { 0 , 0 , 0 }
; static RTWPreprocessingFcnPtr rt_ScopeSignalLoggingPreprocessingFcnPtrs [ ]
= { ( NULL ) , ( NULL ) , ( NULL ) } ; rt_ScopeSignalInfo . numSignals = 3 ;
rt_ScopeSignalInfo . numCols = rt_ScopeSignalWidths ; rt_ScopeSignalInfo .
numDims = rt_ScopeSignalNumDimensions ; rt_ScopeSignalInfo . dims =
rt_ScopeSignalDimensions ; rt_ScopeSignalInfo . isVarDims =
rt_ScopeSignalIsVarDims ; rt_ScopeSignalInfo . currSigDims =
rt_ScopeCurrSigDims ; rt_ScopeSignalInfo . currSigDimsSize =
rt_ScopeCurrSigDimsSize ; rt_ScopeSignalInfo . dataTypes = dTypes ;
rt_ScopeSignalInfo . complexSignals = ( NULL ) ; rt_ScopeSignalInfo .
frameData = rt_ScopeFrameData ; rt_ScopeSignalInfo . preprocessingPtrs =
rt_ScopeSignalLoggingPreprocessingFcnPtrs ; rt_ScopeSignalInfo . labels .
cptr = rt_ScopeSignalLabels ; rt_ScopeSignalInfo . titles =
rt_ScopeSignalTitles ; rt_ScopeSignalInfo . titleLengths =
rt_ScopeSignalTitleLengths ; rt_ScopeSignalInfo . plotStyles =
rt_ScopeSignalPlotStyles ; rt_ScopeSignalInfo . blockNames . cptr = ( NULL )
; rt_ScopeSignalInfo . stateNames . cptr = ( NULL ) ; rt_ScopeSignalInfo .
crossMdlRef = ( NULL ) ; rt_ScopeSignalInfo . dataTypeConvert = ( NULL ) ;
rtDW . fop0wnjdpc . LoggedData [ 0 ] = rt_CreateStructLogVar (
ssGetRTWLogInfo ( rtS ) , ssGetTStart ( rtS ) , ssGetTFinal ( rtS ) , 0.0 , (
& ssGetErrorStatus ( rtS ) ) , "ScopeData" , 1 , 0 , 1 , 0.0 , &
rt_ScopeSignalInfo , rt_ScopeBlockName ) ; if ( rtDW . fop0wnjdpc .
LoggedData [ 0 ] == ( NULL ) ) return ; ssCachePointer ( rtS , & ( rtDW .
fop0wnjdpc . LoggedData [ 0 ] ) ) ; } rtB . kavhf2n2dt = rtP .
PendulumwithsimpleDCmotormodel_theta0 ; MdlInitialize ( ) ; } void MdlOutputs
( int_T tid ) { real_T hcfctg1k0u ; real_T leisgdomk5 ; real_T * lastU ; if (
ssIsMajorTimeStep ( rtS ) ) { if ( rtDW . bygdd4hn3h != 0 ) { rtX .
fqq1sxonv5 = rtB . kavhf2n2dt ; } rtB . mqldei4mxm = rtX . fqq1sxonv5 ; }
else { rtB . mqldei4mxm = rtX . fqq1sxonv5 ; } rtY . cshogg3pxi = rtB .
mqldei4mxm ; rtB . kcgo5pdtwx = rtX . c3z3c33bnj ; rtY . gtmzuvksgc = rtB .
kcgo5pdtwx ; rtB . gkd5hkbora = rtP . positionsetpoint_Value - rtB .
kcgo5pdtwx ; rtB . ecpggtixws = rtP . PIDController1_D * rtB . gkd5hkbora ;
if ( ( rtDW . pqewfscbbz >= ssGetT ( rtS ) ) && ( rtDW . jmqcdoq5yq >= ssGetT
( rtS ) ) ) { hcfctg1k0u = 0.0 ; } else { leisgdomk5 = rtDW . pqewfscbbz ;
lastU = & rtDW . j0dwbzuyks ; if ( rtDW . pqewfscbbz < rtDW . jmqcdoq5yq ) {
if ( rtDW . jmqcdoq5yq < ssGetT ( rtS ) ) { leisgdomk5 = rtDW . jmqcdoq5yq ;
lastU = & rtDW . fgimvn0lfv ; } } else { if ( rtDW . pqewfscbbz >= ssGetT (
rtS ) ) { leisgdomk5 = rtDW . jmqcdoq5yq ; lastU = & rtDW . fgimvn0lfv ; } }
hcfctg1k0u = ( rtB . ecpggtixws - * lastU ) / ( ssGetT ( rtS ) - leisgdomk5 )
; } rtB . j5pjftq3nr = rtP . anglesetpoint_Value - rtB . mqldei4mxm ; rtB .
nd41acnict = rtP . PIDController_D * rtB . j5pjftq3nr ; if ( ( rtDW .
b1ongj3jd4 >= ssGetT ( rtS ) ) && ( rtDW . llmahncqtr >= ssGetT ( rtS ) ) ) {
leisgdomk5 = 0.0 ; } else { leisgdomk5 = rtDW . b1ongj3jd4 ; lastU = & rtDW .
imu0ukszsd ; if ( rtDW . b1ongj3jd4 < rtDW . llmahncqtr ) { if ( rtDW .
llmahncqtr < ssGetT ( rtS ) ) { leisgdomk5 = rtDW . llmahncqtr ; lastU = &
rtDW . bczs4gywqv ; } } else { if ( rtDW . b1ongj3jd4 >= ssGetT ( rtS ) ) {
leisgdomk5 = rtDW . llmahncqtr ; lastU = & rtDW . bczs4gywqv ; } } leisgdomk5
= ( rtB . nd41acnict - * lastU ) / ( ssGetT ( rtS ) - leisgdomk5 ) ; } rtB .
luhxo3sjcz = ( ( rtP . PIDController1_P * rtB . gkd5hkbora + rtP . Integral_C
* rtX . dabk3wvnps ) + hcfctg1k0u ) * rtP . Gain_Gain - ( ( rtP .
PIDController_P * rtB . j5pjftq3nr + rtP . Integral_C_ba5drzgqpp * rtX .
divdvbvhoq ) + leisgdomk5 ) * rtP . Gain1_Gain ; rtY . dam3gsto5g = rtB .
luhxo3sjcz ; if ( ssGetLogOutput ( rtS ) ) { StructLogVar * svar = (
StructLogVar * ) rtDW . fop0wnjdpc . LoggedData [ 0 ] ; LogVar * var = svar
-> signals . values ; { double locTime = ssGetTaskTime ( rtS , 0 ) ; ;
rt_UpdateLogVar ( ( LogVar * ) svar -> time , & locTime , 0 ) ; } { real_T
up0 [ 1 ] ; up0 [ 0 ] = rtB . kcgo5pdtwx ; rt_UpdateLogVar ( ( LogVar * ) var
, up0 , 0 ) ; var = var -> next ; } { real_T up1 [ 1 ] ; up1 [ 0 ] = rtB .
mqldei4mxm ; rt_UpdateLogVar ( ( LogVar * ) var , up1 , 0 ) ; var = var ->
next ; } { real_T up2 [ 1 ] ; up2 [ 0 ] = rtB . luhxo3sjcz ; rt_UpdateLogVar
( ( LogVar * ) var , up2 , 0 ) ; } } hcfctg1k0u = muDoubleScalarSin ( rtB .
mqldei4mxm ) ; rtB . na0hnm0ahn = rtX . nl0fba1ca3 ; leisgdomk5 =
muDoubleScalarCos ( rtB . mqldei4mxm ) ; if ( ssIsSampleHit ( rtS , 1 , 0 ) )
{ rtB . krvnj1tdvz = rtDW . hcfky4ne0s ; } rtB . b3p20auilt = ( ( rtP .
PendulumwithsimpleDCmotormodel_g * rtP . PendulumwithsimpleDCmotormodel_m *
rtP . PendulumwithsimpleDCmotormodel_L * hcfctg1k0u - rtP .
PendulumwithsimpleDCmotormodel_m * rtP . PendulumwithsimpleDCmotormodel_L *
leisgdomk5 * rtB . krvnj1tdvz ) - rtP .
PendulumwithsimpleDCmotormodel_pend_damp * rtB . na0hnm0ahn ) / rtB .
ptqflg33mj ; rtB . p234tnqihm = rtX . khq5j2xzhz ; rtB . di5ykdprrn = ( ( (
rtP . PendulumwithsimpleDCmotormodel_L * rtP .
PendulumwithsimpleDCmotormodel_m * hcfctg1k0u * ( rtB . na0hnm0ahn * rtB .
na0hnm0ahn ) + rtP . voltagetoforce_Gain * rtB . luhxo3sjcz ) - rtP .
PendulumwithsimpleDCmotormodel_L * rtP . PendulumwithsimpleDCmotormodel_m *
leisgdomk5 * rtB . b3p20auilt ) - rtP .
PendulumwithsimpleDCmotormodel_cart_friction * rtB . p234tnqihm ) / rtB .
m35hwgvkjs ; UNUSED_PARAMETER ( tid ) ; } void MdlOutputsTID2 ( int_T tid ) {
rtB . m35hwgvkjs = rtP . PendulumwithsimpleDCmotormodel_m + rtP .
PendulumwithsimpleDCmotormodel_cM ; rtB . ptqflg33mj = rtP .
PendulumwithsimpleDCmotormodel_L * rtP . PendulumwithsimpleDCmotormodel_L *
rtP . PendulumwithsimpleDCmotormodel_m + rtP .
PendulumwithsimpleDCmotormodel_I ; rtB . kavhf2n2dt = rtP .
PendulumwithsimpleDCmotormodel_theta0 ; UNUSED_PARAMETER ( tid ) ; } void
MdlUpdate ( int_T tid ) { real_T * lastU ; rtDW . bygdd4hn3h = 0 ; if ( rtDW
. pqewfscbbz == ( rtInf ) ) { rtDW . pqewfscbbz = ssGetT ( rtS ) ; lastU = &
rtDW . j0dwbzuyks ; } else if ( rtDW . jmqcdoq5yq == ( rtInf ) ) { rtDW .
jmqcdoq5yq = ssGetT ( rtS ) ; lastU = & rtDW . fgimvn0lfv ; } else if ( rtDW
. pqewfscbbz < rtDW . jmqcdoq5yq ) { rtDW . pqewfscbbz = ssGetT ( rtS ) ;
lastU = & rtDW . j0dwbzuyks ; } else { rtDW . jmqcdoq5yq = ssGetT ( rtS ) ;
lastU = & rtDW . fgimvn0lfv ; } * lastU = rtB . ecpggtixws ; if ( rtDW .
b1ongj3jd4 == ( rtInf ) ) { rtDW . b1ongj3jd4 = ssGetT ( rtS ) ; lastU = &
rtDW . imu0ukszsd ; } else if ( rtDW . llmahncqtr == ( rtInf ) ) { rtDW .
llmahncqtr = ssGetT ( rtS ) ; lastU = & rtDW . bczs4gywqv ; } else if ( rtDW
. b1ongj3jd4 < rtDW . llmahncqtr ) { rtDW . b1ongj3jd4 = ssGetT ( rtS ) ;
lastU = & rtDW . imu0ukszsd ; } else { rtDW . llmahncqtr = ssGetT ( rtS ) ;
lastU = & rtDW . bczs4gywqv ; } * lastU = rtB . nd41acnict ; if (
ssIsSampleHit ( rtS , 1 , 0 ) ) { rtDW . hcfky4ne0s = rtB . di5ykdprrn ; }
UNUSED_PARAMETER ( tid ) ; } void MdlUpdateTID2 ( int_T tid ) {
UNUSED_PARAMETER ( tid ) ; } void MdlDerivatives ( void ) { XDot * _rtXdot ;
_rtXdot = ( ( XDot * ) ssGetdX ( rtS ) ) ; _rtXdot -> fqq1sxonv5 = rtB .
na0hnm0ahn ; _rtXdot -> c3z3c33bnj = rtB . p234tnqihm ; _rtXdot -> dabk3wvnps
= 0.0 ; _rtXdot -> dabk3wvnps += rtP . Integral_A * rtX . dabk3wvnps ;
_rtXdot -> dabk3wvnps += rtB . gkd5hkbora ; _rtXdot -> divdvbvhoq = 0.0 ;
_rtXdot -> divdvbvhoq += rtP . Integral_A_k15zlijgrn * rtX . divdvbvhoq ;
_rtXdot -> divdvbvhoq += rtB . j5pjftq3nr ; _rtXdot -> nl0fba1ca3 = rtB .
b3p20auilt ; _rtXdot -> khq5j2xzhz = rtB . di5ykdprrn ; } void MdlProjection
( void ) { } void MdlTerminate ( void ) { } void MdlInitializeSizes ( void )
{ ssSetNumContStates ( rtS , 6 ) ; ssSetNumPeriodicContStates ( rtS , 0 ) ;
ssSetNumY ( rtS , 3 ) ; ssSetNumU ( rtS , 0 ) ; ssSetDirectFeedThrough ( rtS
, 0 ) ; ssSetNumSampleTimes ( rtS , 2 ) ; ssSetNumBlocks ( rtS , 50 ) ;
ssSetNumBlockIO ( rtS , 15 ) ; ssSetNumBlockParams ( rtS , 25 ) ; } void
MdlInitializeSampleTimes ( void ) { ssSetSampleTime ( rtS , 0 , 0.0 ) ;
ssSetSampleTime ( rtS , 1 , 0.001 ) ; ssSetOffsetTime ( rtS , 0 , 0.0 ) ;
ssSetOffsetTime ( rtS , 1 , 0.0 ) ; } void raccel_set_checksum ( ) {
ssSetChecksumVal ( rtS , 0 , 2343522158U ) ; ssSetChecksumVal ( rtS , 1 ,
371102075U ) ; ssSetChecksumVal ( rtS , 2 , 323406722U ) ; ssSetChecksumVal (
rtS , 3 , 1538438267U ) ; }
#if defined(_MSC_VER)
#pragma optimize( "", off )
#endif
SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) {
static struct _ssMdlInfo mdlInfo ; ( void ) memset ( ( char * ) rtS , 0 ,
sizeof ( SimStruct ) ) ; ( void ) memset ( ( char * ) & mdlInfo , 0 , sizeof
( struct _ssMdlInfo ) ) ; ssSetMdlInfoPtr ( rtS , & mdlInfo ) ;
ssSetExecutionInfo ( rtS , executionInfo ) ; { static time_T mdlPeriod [
NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ; static time_T
mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [ NSAMPLE_TIMES ] ;
static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static boolean_T
mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T mdlPerTaskSampleHits
[ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T mdlTimeOfNextSampleHit [
NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i < NSAMPLE_TIMES ; i ++ ) {
mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ; mdlTaskTimes [ i ] = 0.0 ;
mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } } ssSetSampleTimePtr ( rtS ,
& mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , & mdlOffset [ 0 ] ) ;
ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ; ssSetTPtr ( rtS , &
mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , & mdlSampleHits [ 0 ] ) ;
ssSetTNextWasAdjustedPtr ( rtS , & mdlTNextWasAdjustedPtr [ 0 ] ) ;
ssSetPerTaskSampleHitsPtr ( rtS , & mdlPerTaskSampleHits [ 0 ] ) ;
ssSetTimeOfNextSampleHitPtr ( rtS , & mdlTimeOfNextSampleHit [ 0 ] ) ; }
ssSetSolverMode ( rtS , SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS ,
( ( void * ) & rtB ) ) ; ssSetWorkSizeInBytes ( rtS , sizeof ( rtB ) ,
"BlockIO" ) ; { rtB . mqldei4mxm = 0.0 ; rtB . kcgo5pdtwx = 0.0 ; rtB .
gkd5hkbora = 0.0 ; rtB . ecpggtixws = 0.0 ; rtB . j5pjftq3nr = 0.0 ; rtB .
nd41acnict = 0.0 ; rtB . luhxo3sjcz = 0.0 ; rtB . na0hnm0ahn = 0.0 ; rtB .
krvnj1tdvz = 0.0 ; rtB . b3p20auilt = 0.0 ; rtB . p234tnqihm = 0.0 ; rtB .
di5ykdprrn = 0.0 ; rtB . m35hwgvkjs = 0.0 ; rtB . ptqflg33mj = 0.0 ; rtB .
kavhf2n2dt = 0.0 ; } } { ssSetY ( rtS , & rtY ) ; rtY . cshogg3pxi = 0.0 ;
rtY . gtmzuvksgc = 0.0 ; rtY . dam3gsto5g = 0.0 ; } { real_T * x = ( real_T *
) & rtX ; ssSetContStates ( rtS , x ) ; ( void ) memset ( ( void * ) x , 0 ,
sizeof ( X ) ) ; } { void * dwork = ( void * ) & rtDW ; ssSetRootDWork ( rtS
, dwork ) ; ssSetWorkSizeInBytes ( rtS , sizeof ( rtDW ) , "DWork" ) ; ( void
) memset ( dwork , 0 , sizeof ( DW ) ) ; rtDW . hcfky4ne0s = 0.0 ; rtDW .
pqewfscbbz = 0.0 ; rtDW . j0dwbzuyks = 0.0 ; rtDW . jmqcdoq5yq = 0.0 ; rtDW .
fgimvn0lfv = 0.0 ; rtDW . b1ongj3jd4 = 0.0 ; rtDW . imu0ukszsd = 0.0 ; rtDW .
llmahncqtr = 0.0 ; rtDW . bczs4gywqv = 0.0 ; } { static DataTypeTransInfo
dtInfo ; ( void ) memset ( ( char_T * ) & dtInfo , 0 , sizeof ( dtInfo ) ) ;
ssSetModelMappingInfo ( rtS , & dtInfo ) ; dtInfo . numDataTypes = 14 ;
dtInfo . dataTypeSizes = & rtDataTypeSizes [ 0 ] ; dtInfo . dataTypeNames = &
rtDataTypeNames [ 0 ] ; dtInfo . BTransTable = & rtBTransTable ; dtInfo .
PTransTable = & rtPTransTable ; dtInfo . dataTypeInfoTable =
rtDataTypeInfoTable ; } ModelInvertedPD1_InitializeDataMapInfo ( ) ;
ssSetIsRapidAcceleratorActive ( rtS , true ) ; ssSetRootSS ( rtS , rtS ) ;
ssSetVersion ( rtS , SIMSTRUCT_VERSION_LEVEL2 ) ; ssSetModelName ( rtS ,
"ModelInvertedPD1" ) ; ssSetPath ( rtS , "ModelInvertedPD1" ) ; ssSetTStart (
rtS , 0.0 ) ; ssSetTFinal ( rtS , 200.0 ) ; { static RTWLogInfo
rt_DataLoggingInfo ; rt_DataLoggingInfo . loggingInterval = NULL ;
ssSetRTWLogInfo ( rtS , & rt_DataLoggingInfo ) ; } { { static int_T
rt_LoggedStateWidths [ ] = { 1 , 1 , 1 , 1 , 1 , 1 , 1 } ; static int_T
rt_LoggedStateNumDimensions [ ] = { 1 , 1 , 1 , 1 , 1 , 1 , 1 } ; static
int_T rt_LoggedStateDimensions [ ] = { 1 , 1 , 1 , 1 , 1 , 1 , 1 } ; static
boolean_T rt_LoggedStateIsVarDims [ ] = { 0 , 0 , 0 , 0 , 0 , 0 , 0 } ;
static BuiltInDTypeId rt_LoggedStateDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE
, SS_DOUBLE , SS_DOUBLE , SS_DOUBLE , SS_DOUBLE , SS_DOUBLE } ; static int_T
rt_LoggedStateComplexSignals [ ] = { 0 , 0 , 0 , 0 , 0 , 0 , 0 } ; static
RTWPreprocessingFcnPtr rt_LoggingStatePreprocessingFcnPtrs [ ] = { ( NULL ) ,
( NULL ) , ( NULL ) , ( NULL ) , ( NULL ) , ( NULL ) , ( NULL ) } ; static
const char_T * rt_LoggedStateLabels [ ] = { "CSTATE" , "CSTATE" , "CSTATE" ,
"CSTATE" , "CSTATE" , "CSTATE" , "DSTATE" } ; static const char_T *
rt_LoggedStateBlockNames [ ] = {
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator3" ,
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator1" ,
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller1/Integral" ,
"ModelInvertedPD1/Inverted pendulum stabilization/PID Controller/Integral" ,
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator2" ,
"ModelInvertedPD1/Pendulum with simple DC motor model/Integrator" ,
"ModelInvertedPD1/Pendulum with simple DC motor model/Unit Delay" } ; static
const char_T * rt_LoggedStateNames [ ] = { "" , "" , "" , "" , "" , "" , "" }
; static boolean_T rt_LoggedStateCrossMdlRef [ ] = { 0 , 0 , 0 , 0 , 0 , 0 ,
0 } ; static RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 ,
SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0
, 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 ,
0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 ,
SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } } ; static RTWLogSignalInfo
rt_LoggedStateSignalInfo = { 7 , rt_LoggedStateWidths ,
rt_LoggedStateNumDimensions , rt_LoggedStateDimensions ,
rt_LoggedStateIsVarDims , ( NULL ) , ( NULL ) , rt_LoggedStateDataTypeIds ,
rt_LoggedStateComplexSignals , ( NULL ) , rt_LoggingStatePreprocessingFcnPtrs
, { rt_LoggedStateLabels } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedStateBlockNames } , { rt_LoggedStateNames } ,
rt_LoggedStateCrossMdlRef , rt_RTWLogDataTypeConvert } ; static void *
rt_LoggedStateSignalPtrs [ 7 ] ; rtliSetLogXSignalPtrs ( ssGetRTWLogInfo (
rtS ) , ( LogSignalPtrsType ) rt_LoggedStateSignalPtrs ) ;
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , & rt_LoggedStateSignalInfo
) ; rt_LoggedStateSignalPtrs [ 0 ] = ( void * ) & rtX . fqq1sxonv5 ;
rt_LoggedStateSignalPtrs [ 1 ] = ( void * ) & rtX . c3z3c33bnj ;
rt_LoggedStateSignalPtrs [ 2 ] = ( void * ) & rtX . dabk3wvnps ;
rt_LoggedStateSignalPtrs [ 3 ] = ( void * ) & rtX . divdvbvhoq ;
rt_LoggedStateSignalPtrs [ 4 ] = ( void * ) & rtX . nl0fba1ca3 ;
rt_LoggedStateSignalPtrs [ 5 ] = ( void * ) & rtX . khq5j2xzhz ;
rt_LoggedStateSignalPtrs [ 6 ] = ( void * ) & rtDW . hcfky4ne0s ; }
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "tmp_raccel_xout" ) ; rtliSetLogXFinal (
ssGetRTWLogInfo ( rtS ) , "xFinal" ) ; rtliSetLogVarNameModifier (
ssGetRTWLogInfo ( rtS ) , "none" ) ; rtliSetLogFormat ( ssGetRTWLogInfo ( rtS
) , 2 ) ; rtliSetLogMaxRows ( ssGetRTWLogInfo ( rtS ) , 1000 ) ;
rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS ) , 1 ) ; { static void *
rt_LoggedOutputSignalPtrs [ ] = { & rtY . cshogg3pxi , & rtY . gtmzuvksgc , &
rtY . dam3gsto5g } ; rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( (
LogSignalPtrsType ) rt_LoggedOutputSignalPtrs ) ) ; } { static int_T
rt_LoggedOutputWidths [ ] = { 1 , 1 , 1 } ; static int_T
rt_LoggedOutputNumDimensions [ ] = { 1 , 1 , 1 } ; static int_T
rt_LoggedOutputDimensions [ ] = { 1 , 1 , 1 } ; static boolean_T
rt_LoggedOutputIsVarDims [ ] = { 0 , 0 , 0 } ; static void *
rt_LoggedCurrentSignalDimensions [ ] = { ( NULL ) , ( NULL ) , ( NULL ) } ;
static int_T rt_LoggedCurrentSignalDimensionsSize [ ] = { 4 , 4 , 4 } ;
static BuiltInDTypeId rt_LoggedOutputDataTypeIds [ ] = { SS_DOUBLE ,
SS_DOUBLE , SS_DOUBLE } ; static int_T rt_LoggedOutputComplexSignals [ ] = {
0 , 0 , 0 } ; static RTWPreprocessingFcnPtr rt_LoggingPreprocessingFcnPtrs [
] = { ( NULL ) , ( NULL ) , ( NULL ) } ; static const char_T *
rt_LoggedOutputLabels_0 [ ] = { "angle" } ; static const char_T *
rt_LoggedOutputBlockNames_0 [ ] = { "ModelInvertedPD1/Out1" } ; static const
char_T * rt_LoggedOutputLabels_1 [ ] = { "position" } ; static const char_T *
rt_LoggedOutputBlockNames_1 [ ] = { "ModelInvertedPD1/Out2" } ; static const
char_T * rt_LoggedOutputLabels_2 [ ] = { "control" } ; static const char_T *
rt_LoggedOutputBlockNames_2 [ ] = { "ModelInvertedPD1/Out3" } ; static
RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0
, 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 ,
0.0 } } ; static RTWLogSignalInfo rt_LoggedOutputSignalInfo [ ] = { { 1 ,
rt_LoggedOutputWidths , rt_LoggedOutputNumDimensions ,
rt_LoggedOutputDimensions , rt_LoggedOutputIsVarDims ,
rt_LoggedCurrentSignalDimensions , rt_LoggedCurrentSignalDimensionsSize ,
rt_LoggedOutputDataTypeIds , rt_LoggedOutputComplexSignals , ( NULL ) ,
rt_LoggingPreprocessingFcnPtrs , { rt_LoggedOutputLabels_0 } , ( NULL ) , (
NULL ) , ( NULL ) , { rt_LoggedOutputBlockNames_0 } , { ( NULL ) } , ( NULL )
, rt_RTWLogDataTypeConvert } , { 1 , rt_LoggedOutputWidths + 1 ,
rt_LoggedOutputNumDimensions + 1 , rt_LoggedOutputDimensions + 1 ,
rt_LoggedOutputIsVarDims + 1 , rt_LoggedCurrentSignalDimensions + 1 ,
rt_LoggedCurrentSignalDimensionsSize + 1 , rt_LoggedOutputDataTypeIds + 1 ,
rt_LoggedOutputComplexSignals + 1 , ( NULL ) , rt_LoggingPreprocessingFcnPtrs
+ 1 , { rt_LoggedOutputLabels_1 } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedOutputBlockNames_1 } , { ( NULL ) } , ( NULL ) ,
rt_RTWLogDataTypeConvert + 1 } , { 1 , rt_LoggedOutputWidths + 2 ,
rt_LoggedOutputNumDimensions + 2 , rt_LoggedOutputDimensions + 2 ,
rt_LoggedOutputIsVarDims + 2 , rt_LoggedCurrentSignalDimensions + 2 ,
rt_LoggedCurrentSignalDimensionsSize + 2 , rt_LoggedOutputDataTypeIds + 2 ,
rt_LoggedOutputComplexSignals + 2 , ( NULL ) , rt_LoggingPreprocessingFcnPtrs
+ 2 , { rt_LoggedOutputLabels_2 } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedOutputBlockNames_2 } , { ( NULL ) } , ( NULL ) ,
rt_RTWLogDataTypeConvert + 2 } } ; rtliSetLogYSignalInfo ( ssGetRTWLogInfo (
rtS ) , rt_LoggedOutputSignalInfo ) ; rt_LoggedCurrentSignalDimensions [ 0 ]
= & rt_LoggedOutputWidths [ 0 ] ; rt_LoggedCurrentSignalDimensions [ 1 ] = &
rt_LoggedOutputWidths [ 1 ] ; rt_LoggedCurrentSignalDimensions [ 2 ] = &
rt_LoggedOutputWidths [ 2 ] ; } rtliSetLogY ( ssGetRTWLogInfo ( rtS ) ,
"tmp_raccel_yout1,tmp_raccel_yout2,tmp_raccel_yout3" ) ; } { static struct
_ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 ) ; } {
static ssPeriodicStatesInfo periodicStatesInfo ; ssSetPeriodicStatesInfo (
rtS , & periodicStatesInfo ) ; } { static ssJacobianPerturbationBounds
jacobianPerturbationBounds ; ssSetJacobianPerturbationBounds ( rtS , &
jacobianPerturbationBounds ) ; } { static ssSolverInfo slvrInfo ; static
boolean_T contStatesDisabled [ 6 ] ; static real_T absTol [ 6 ] = { 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 } ; static uint8_T absTolControl [
6 ] = { 0U , 0U , 0U , 0U , 0U , 0U } ; static real_T
contStateJacPerturbBoundMinVec [ 6 ] ; static real_T
contStateJacPerturbBoundMaxVec [ 6 ] ; static ssNonContDerivSigInfo
nonContDerivSigInfo [ 1 ] = { { 1 * sizeof ( real_T ) , ( char * ) ( & rtB .
krvnj1tdvz ) , ( NULL ) } } ; { int i ; for ( i = 0 ; i < 6 ; ++ i ) {
contStateJacPerturbBoundMinVec [ i ] = 0 ; contStateJacPerturbBoundMaxVec [ i
] = rtGetInf ( ) ; } } ssSetSolverRelTol ( rtS , 0.001 ) ; ssSetStepSize (
rtS , 0.0 ) ; ssSetMinStepSize ( rtS , 0.0 ) ; ssSetMaxNumMinSteps ( rtS , -
1 ) ; ssSetMinStepViolatedError ( rtS , 0 ) ; ssSetMaxStepSize ( rtS , 0.001
) ; ssSetSolverMaxOrder ( rtS , - 1 ) ; ssSetSolverRefineFactor ( rtS , 1 ) ;
ssSetOutputTimes ( rtS , ( NULL ) ) ; ssSetNumOutputTimes ( rtS , 0 ) ;
ssSetOutputTimesOnly ( rtS , 0 ) ; ssSetOutputTimesIndex ( rtS , 0 ) ;
ssSetZCCacheNeedsReset ( rtS , 0 ) ; ssSetDerivCacheNeedsReset ( rtS , 0 ) ;
ssSetNumNonContDerivSigInfos ( rtS , 1 ) ; ssSetNonContDerivSigInfos ( rtS ,
nonContDerivSigInfo ) ; ssSetSolverInfo ( rtS , & slvrInfo ) ;
ssSetSolverName ( rtS , "ode45" ) ; ssSetVariableStepSolver ( rtS , 1 ) ;
ssSetSolverConsistencyChecking ( rtS , 0 ) ; ssSetSolverAdaptiveZcDetection (
rtS , 0 ) ; ssSetSolverRobustResetMethod ( rtS , 0 ) ; ssSetAbsTolVector (
rtS , absTol ) ; ssSetAbsTolControlVector ( rtS , absTolControl ) ;
ssSetSolverAbsTol_Obsolete ( rtS , absTol ) ;
ssSetSolverAbsTolControl_Obsolete ( rtS , absTolControl ) ;
ssSetJacobianPerturbationBoundsMinVec ( rtS , contStateJacPerturbBoundMinVec
) ; ssSetJacobianPerturbationBoundsMaxVec ( rtS ,
contStateJacPerturbBoundMaxVec ) ; ssSetSolverStateProjection ( rtS , 0 ) ;
ssSetSolverMassMatrixType ( rtS , ( ssMatrixType ) 0 ) ;
ssSetSolverMassMatrixNzMax ( rtS , 0 ) ; ssSetModelOutputs ( rtS , MdlOutputs
) ; ssSetModelLogData ( rtS , rt_UpdateTXYLogVars ) ;
ssSetModelLogDataIfInInterval ( rtS , rt_UpdateTXXFYLogVars ) ;
ssSetModelUpdate ( rtS , MdlUpdate ) ; ssSetModelDerivatives ( rtS ,
MdlDerivatives ) ; ssSetSolverMaxConsecutiveMinStep ( rtS , 1 ) ;
ssSetSolverShapePreserveControl ( rtS , 2 ) ; ssSetTNextTid ( rtS , INT_MIN )
; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset ( rtS ) ;
ssSetNumNonsampledZCs ( rtS , 0 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; ssSetSolverMaxConsecutiveMinStep ( rtS , 1 ) ; }
ssSetChecksumVal ( rtS , 0 , 2343522158U ) ; ssSetChecksumVal ( rtS , 1 ,
371102075U ) ; ssSetChecksumVal ( rtS , 2 , 323406722U ) ; ssSetChecksumVal (
rtS , 3 , 1538438267U ) ; { static const sysRanDType rtAlwaysEnabled =
SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo rt_ExtModeInfo ; static const
sysRanDType * systemRan [ 1 ] ; gblRTWExtModeInfo = & rt_ExtModeInfo ;
ssSetRTWExtModeInfo ( rtS , & rt_ExtModeInfo ) ;
rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo , systemRan ) ;
systemRan [ 0 ] = & rtAlwaysEnabled ; rteiSetModelMappingInfoPtr (
ssGetRTWExtModeInfo ( rtS ) , & ssGetModelMappingInfo ( rtS ) ) ;
rteiSetChecksumsPtr ( ssGetRTWExtModeInfo ( rtS ) , ssGetChecksums ( rtS ) )
; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS ) , ssGetTPtr ( rtS ) ) ; } return
rtS ; }
#if defined(_MSC_VER)
#pragma optimize( "", on )
#endif
const int_T gblParameterTuningTid = 2 ; void MdlOutputsParameterSampleTime (
int_T tid ) { MdlOutputsTID2 ( tid ) ; }
