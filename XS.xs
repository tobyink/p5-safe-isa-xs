#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"

int _mycall (char* methodname, SV* args[], int argc)
{
	int i;
	int result_count;
	
	if (! sv_isobject(args[0]))
	{
		return 0;
	}
	
	dSP;
	SP -= argc;
	
	// Prepare to call method
	ENTER;
	SAVETMPS;
	PUSHMARK(SP);
	for (i=0; i<argc; i++)
	{
		XPUSHs(args[i]);
	}
	PUTBACK;
	
	// Call method
	result_count = call_method(methodname, GIMME_V);
	SPAGAIN;
	
	// Unpack return results
	SV* ret[result_count];
	for (i=0; i<result_count; i++)
	{
		ret[i] = POPs;
	}
	PUTBACK;
	
	// Return results
	for (i=result_count-1; i>=0; i--)
	{
		XPUSHs(ret[i]);
	}
	PUTBACK;
//	FREETMPS;
	LEAVE;
	
	return result_count;
}

MODULE = Safe::Isa::XS		PACKAGE = Safe::Isa::XS

INCLUDE: const-xs.inc

void
_isa (obj, ...)
	SV *obj
PPCODE:
{
	SV* args[items];
	int i;
	for (i = 0; i < items; i++) {
		args[i] = ST(i);
	}
	XSRETURN( _mycall("isa", args, items) );
}

void
_can (obj, ...)
	SV *obj
PPCODE:
{
	SV* args[items];
	int i;
	for (i = 0; i < items; i++) {
		args[i] = ST(i);
	}
	XSRETURN( _mycall("can", args, items) );
}

void
_does (obj, ...)
	SV *obj
PPCODE:
{
	SV* args[items];
	int i;
	for (i = 0; i < items; i++) {
		args[i] = ST(i);
	}
	XSRETURN( _mycall("does", args, items) );
}

void
_DOES (obj, ...)
	SV *obj
PPCODE:
{
	SV* args[items];
	int i;
	for (i = 0; i < items; i++) {
		args[i] = ST(i);
	}
	XSRETURN( _mycall("DOES", args, items) );
}
